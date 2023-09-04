import std/[
  os,
  sequtils,
  strutils,
  strformat,
]
import beyond/[defects]
import godot
import godot/logging

import ./tester

# type
#   ExampleRef {.deprecated.} = object
#   ExampleMin {.deprecated.} = object
#   Example {.deprecated.} = object
#   ExampleVirtual {.deprecated.} = object
#   ExampleAbstract {.deprecated.} = object

# proc register_abstract_class[T](is_virtual: bool = false) {.staticOf: ClassDB, unimplemented.}

defects.unimplementedCallback =
  proc(msg: string) =
    iam("unimplemented", stgLibrary).warn msg

proc format {.implement: LogFormat.} =
  let data = GDLogData data
  fmt "{levelname}-{stage} @{handler} >>> {summary}\n{args.join().splitLines().mapIt(\"  :: \"&it).join()}"

proc newDemoLogger: FileLogger =
  createDir("log")
  newFileLogger("log/demo.log", fmWrite, format= format)

defaultGroup.loggers.add newDemoLogger()
# defaultGroup.loggers.add newConsoleLogger(format= format)


proc initialize(lvl: InitializationLevel): void =
  iam("initialize-module").debug "demo.initialize was called, level = " & $lvl
  if lvl != Initialization_Scene: return

  # ClassDB|>register_class(ExampleRef)
  # ClassDB|>register_class(ExampleMin)
  # ClassDB|>register_class(Example)
  # ClassDB|>register_class(ExampleVirtual,true)
  # ClassDB|>register_abstract_class[ExampleAbstract]()
  tester.test_pure()
  register tester.Tester

proc terminate(lvl: InitializationLevel): void =
  iam("terminate-module").debug "demo.terminate was called, level = " & $lvl
  if lvl != Initialization_Scene: return

let cfg = GDExtensionConfig(
  initializer: initialize,
  terminator: terminate,
  minimumInitializationLevel: Initialization_Editor
)

GDExtension_EntryPoint init_library, cfg