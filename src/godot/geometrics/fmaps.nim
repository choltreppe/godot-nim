import std/sequtils
import std/options
import beyond/[
  macros,
]

func makeAccessor(v: NimNode; length: int; name: string): tuple[letval: Option[NimNode]; accessor: seq[NimNode]] =
  result.accessor = newSeq[NimNode](length)
  case v.kind
  of {nnkSym, nnkIdent}:
    for i, arg in result.accessor.mpairs:
      arg = nnkBracketExpr.newTree(v, newLit i)
  of nnkBracket:
    for i, arg in result.accessor.mpairs:
      arg = v[i]
  else:
    let arg0 = genSym(nskLet, name)
    result.letval = some newIdentDefs(arg0, newEmptyNode(), v)
    for i, arg in result.accessor.mpairs:
      arg = nnkBracketExpr.newTree(arg0, newLit i)


template `<$>`*(exp: untyped; x: untyped): untyped = x.fmap(exp)

macro fmap*[N: static int; T](_: typedesc[array[N,T]]; exp: untyped): array[N,T] =
  nnkBracket.newTree exp.repeat(N)

macro fmap*[N: static int; T](v: array[N,T]; exp: untyped): untyped =
  var letsec = newNimNode nnkLetSection
  let
    arg0 = makeAccessor(v, N, "arg0")

  if arg0.letval.isSome: letsec.add(get arg0.letval)
  var bracket = newNimNode(nnkBracket)
  for i in 0..<N: bracket.add exp
    .replaceIdent("a", arg0.accessor[i])
    .replaceIdent("i", newLit i)

  result = newStmtList()
  if letsec.len != 0:
    result.add letsec
  result.add bracket

macro fmap*[N: static int; T,S](vs: (array[N,T], array[N,S]); exp: untyped): untyped =
  var letsec = newNimNode nnkLetSection
  let
    arg0 = makeAccessor(vs[0], N, "arg0")
    arg1 = makeAccessor(vs[1], N, "arg1")
  
  if arg0.letval.isSome: letsec.add(get arg0.letval)
  if arg1.letval.isSome: letsec.add(get arg1.letval)

  var bracket = newNimNode(nnkBracket)
  for i in 0..<N: bracket.add exp
    .replaceIdent("a", arg0.accessor[i])
    .replaceIdent("b", arg1.accessor[i])
    .replaceIdent("i", newLit i)

  result = newStmtList()
  if letsec.len != 0:
    result.add letsec
  result.add bracket

macro fmap*[N: static int; T,S,R](vs: (array[N,T], array[N,S], array[N,R]); exp: untyped): untyped =
  var letsec = newNimNode nnkLetSection
  let
    arg0 = makeAccessor(vs[0], N, "arg0")
    arg1 = makeAccessor(vs[1], N, "arg1")
    arg2 = makeAccessor(vs[2], N, "arg2")
  
  if arg0.letval.isSome: letsec.add(get arg0.letval)
  if arg1.letval.isSome: letsec.add(get arg1.letval)
  if arg2.letval.isSome: letsec.add(get arg2.letval)

  var bracket = newNimNode(nnkBracket)
  for i in 0..<N: bracket.add exp
    .replaceIdent("a", arg0.accessor[i])
    .replaceIdent("b", arg1.accessor[i])
    .replaceIdent("c", arg2.accessor[i])
    .replaceIdent("i", newLit i)

  result = newStmtList()
  if letsec.len != 0:
    result.add letsec
  result.add bracket

template all*[N: static int; T](s: array[N, T]; pred): bool =
  var result = true
  for i {.inject.} in 0..<N:
    let
      a {.inject.} = s[i]
    if not pred:
      result = false
      break
  result
template all*[N: static int; T,S](s0: array[N,T]; s1: array[N,S]; pred): bool =
  var result = true
  for i {.inject.} in 0..<N:
    let
      a {.inject.} = s0[i]
      b {.inject.} = s1[i]
    if not pred:
      result = false
      break
  result