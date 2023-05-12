## This module is generated automatically.
import ../essentials

# type GdNodePath* = object
  # self.base.is_keyed=false
  # self.base.has_destructor=true
  # self.base.indexing_return_type=none(string)
  # self.base.constants=none(seq[GdConstant])

GdNodePath.procedures(loader= loadProcs_GdNodePath):
  proc `getAsPropertyPath`*(self:GdNodePath): GdNodePath {.loadfrom("get_as_property_path", 1598598043).}
  proc `getConcatenatedNames`*(self:GdNodePath): GdStringName {.loadfrom("get_concatenated_names", 1825232092).}
  proc `getConcatenatedSubnames`*(self:GdNodePath): GdStringName {.loadfrom("get_concatenated_subnames", 1825232092).}
  proc `getNameCount`*(self:GdNodePath): GdInt {.loadfrom("get_name_count", 3173160232).}
  proc `getName`*(self:GdNodePath; `idx`:GdInt): GdStringName {.loadfrom("get_name", 2948586938).}
  proc `getSubnameCount`*(self:GdNodePath): GdInt {.loadfrom("get_subname_count", 3173160232).}
  proc `getSubname`*(self:GdNodePath; `idx`:GdInt): GdStringName {.loadfrom("get_subname", 2948586938).}
  proc `hash`*(self:GdNodePath): GdInt {.loadfrom("hash", 3173160232).}
  proc `isAbsolute`*(self:GdNodePath): GdBool {.loadfrom("is_absolute", 3918633141).}
  proc `isEmpty`*(self:GdNodePath): GdBool {.loadfrom("is_empty", 3918633141).}

GdNodePath.operators(loader= loadOperators_GdNodePath):
  proc `!=`*(left:GdNodePath; right:GdVariant): GdBool {.operator: GdVariantOperator.NotEqual.}
  proc `!=`*(left:GdNodePath; right:GdNodePath): GdBool {.operator: GdVariantOperator.NotEqual.}
  proc `==`*(left:GdNodePath; right:GdVariant): GdBool {.operator: GdVariantOperator.Equal.}
  proc `==`*(left:GdNodePath; right:GdNodePath): GdBool {.operator: GdVariantOperator.Equal.}
  proc contains*(left:GdDictionary; right:GdNodePath): GdBool {.operator: GdVariantOperator.In.}
  proc contains*(left:GdArray; right:GdNodePath): GdBool {.operator: GdVariantOperator.In.}
proc load*(_:typedesc[GdNodePath]) =
  loadProcs_GdNodePath()
  loadOperators_GdNodePath()
