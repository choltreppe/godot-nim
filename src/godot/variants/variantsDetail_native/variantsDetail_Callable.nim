# ======================================== #
# This module was generated automatically. #
# Edits will be lost.                      #
# ======================================== #
import ./../../helper/variantDefiner

# type Callable* = object
#   self.json.is_keyed=false
#   self.json.indexing_return_type=none(string)
var Callable_callv: PtrBuiltinMethod
var Callable_isNull: PtrBuiltinMethod
var Callable_isCustom: PtrBuiltinMethod
var Callable_isStandard: PtrBuiltinMethod
var Callable_isValid: PtrBuiltinMethod
var Callable_getObject: PtrBuiltinMethod
var Callable_getObjectId: PtrBuiltinMethod
var Callable_getMethod: PtrBuiltinMethod
var Callable_getBoundArgumentsCount: PtrBuiltinMethod
var Callable_getBoundArguments: PtrBuiltinMethod
var Callable_hash: PtrBuiltinMethod
var Callable_bindv: PtrBuiltinMethod
var Callable_unbind: PtrBuiltinMethod
var Callable_call: PtrBuiltinMethod
var Callable_callDeferred: PtrBuiltinMethod
var Callable_rpc: PtrBuiltinMethod
var Callable_rpcId: PtrBuiltinMethod
var Callable_bind: PtrBuiltinMethod
proc callv*(self: Callable; arguments: Array): Variant =
  let argArr = [cast[pointer](addr arguments)]
  Callable_callv(addr self, addr argArr[0], addr result, 1)
proc isNull*(self: Callable): Bool = Callable_isNull(addr self, nil, addr result, 0)
proc isCustom*(self: Callable): Bool = Callable_isCustom(addr self, nil, addr result, 0)
proc isStandard*(self: Callable): Bool = Callable_isStandard(addr self, nil, addr result, 0)
proc isValid*(self: Callable): Bool = Callable_isValid(addr self, nil, addr result, 0)
proc getObject*(self: Callable): Object = Callable_getObject(addr self, nil, addr result, 0)
proc getObjectId*(self: Callable): Int = Callable_getObjectId(addr self, nil, addr result, 0)
proc getMethod*(self: Callable): StringName = Callable_getMethod(addr self, nil, addr result, 0)
proc getBoundArgumentsCount*(self: Callable): Int = Callable_getBoundArgumentsCount(addr self, nil, addr result, 0)
proc getBoundArguments*(self: Callable): Array = Callable_getBoundArguments(addr self, nil, addr result, 0)
proc hash*(self: Callable): Int = Callable_hash(addr self, nil, addr result, 0)
proc bindv*(self: Callable; arguments: Array): Callable =
  let argArr = [cast[pointer](addr arguments)]
  Callable_bindv(addr self, addr argArr[0], addr result, 1)
proc unbind*(self: Callable; argcount: Int): Callable =
  let argArr = [cast[pointer](addr argcount)]
  Callable_unbind(addr self, addr argArr[0], addr result, 1)
proc call*(self: Callable): Variant = Callable_call(addr self, nil, addr result, 0)
proc callDeferred*(self: Callable) = Callable_callDeferred(addr self, nil, nil, 0)
proc rpc*(self: Callable) = Callable_rpc(addr self, nil, nil, 0)
proc rpcId*(self: Callable; peerId: Int) =
  let argArr = [cast[pointer](addr peerId)]
  Callable_rpcId(addr self, addr argArr[0], nil, 1)
proc `bind`*(self: Callable): Callable = Callable_bind(addr self, nil, addr result, 0)
proc load_Callable_proc =
  var proc_name: StringName
  proc_name = init_StringName("callv")
  Callable_callv = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 413578926)
  proc_name = init_StringName("is_null")
  Callable_isNull = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 3918633141)
  proc_name = init_StringName("is_custom")
  Callable_isCustom = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 3918633141)
  proc_name = init_StringName("is_standard")
  Callable_isStandard = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 3918633141)
  proc_name = init_StringName("is_valid")
  Callable_isValid = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 3918633141)
  proc_name = init_StringName("get_object")
  Callable_getObject = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 4008621732)
  proc_name = init_StringName("get_object_id")
  Callable_getObjectId = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 3173160232)
  proc_name = init_StringName("get_method")
  Callable_getMethod = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 1825232092)
  proc_name = init_StringName("get_bound_arguments_count")
  Callable_getBoundArgumentsCount = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 3173160232)
  proc_name = init_StringName("get_bound_arguments")
  Callable_getBoundArguments = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 4144163970)
  proc_name = init_StringName("hash")
  Callable_hash = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 3173160232)
  proc_name = init_StringName("bindv")
  Callable_bindv = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 3564560322)
  proc_name = init_StringName("unbind")
  Callable_unbind = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 755001590)
  proc_name = init_StringName("call")
  Callable_call = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 3643564216)
  proc_name = init_StringName("call_deferred")
  Callable_callDeferred = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 3286317445)
  proc_name = init_StringName("rpc")
  Callable_rpc = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 3286317445)
  proc_name = init_StringName("rpc_id")
  Callable_rpcId = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 2270047679)
  proc_name = init_StringName("bind")
  Callable_bind = interface_Variant_getPtrBuiltinMethod(variantType Callable, addr proc_name, 3224143119)
var Equal_Callable_Variant: PtrOperatorEvaluator
var NotEqual_Callable_Variant: PtrOperatorEvaluator
var Not_Callable: PtrOperatorEvaluator
var Equal_Callable_Callable: PtrOperatorEvaluator
var NotEqual_Callable_Callable: PtrOperatorEvaluator
var In_Callable_Dictionary: PtrOperatorEvaluator
var In_Callable_Array: PtrOperatorEvaluator
proc `==`*(left: Callable; right: ptr Variant): Bool = Equal_Callable_Variant(addr left, addr right, addr result)
proc `!=`*(left: Callable; right: ptr Variant): Bool = NotEqual_Callable_Variant(addr left, addr right, addr result)
proc `not`*(left: Callable): Bool = Not_Callable(addr left, nil, addr result)
proc `==`*(left: Callable; right: Callable): Bool = Equal_Callable_Callable(addr left, addr right, addr result)
proc `!=`*(left: Callable; right: Callable): Bool = NotEqual_Callable_Callable(addr left, addr right, addr result)
proc contains*(left: Dictionary; right: Callable): Bool = In_Callable_Dictionary(addr right, addr left, addr result)
proc contains*(left: Array; right: Callable): Bool = In_Callable_Array(addr right, addr left, addr result)
proc load_Callable_op =
  Equal_Callable_Variant = interface_variantGetPtrOperatorEvaluator(VariantOP_Equal, VariantType_Callable, VariantType_Nil)
  NotEqual_Callable_Variant = interface_variantGetPtrOperatorEvaluator(VariantOP_NotEqual, VariantType_Callable, VariantType_Nil)
  Not_Callable = interface_variantGetPtrOperatorEvaluator(VariantOP_Not, VariantType_Callable, VariantType_Nil)
  Equal_Callable_Callable = interface_variantGetPtrOperatorEvaluator(VariantOP_Equal, VariantType_Callable, VariantType_Callable)
  NotEqual_Callable_Callable = interface_variantGetPtrOperatorEvaluator(VariantOP_NotEqual, VariantType_Callable, VariantType_Callable)
  In_Callable_Dictionary = interface_variantGetPtrOperatorEvaluator(VariantOP_In, VariantType_Callable, VariantType_Dictionary)
  In_Callable_Array = interface_variantGetPtrOperatorEvaluator(VariantOP_In, VariantType_Callable, VariantType_Array)
proc load_Callable_allmethod* =
  load_Callable_op()
  load_Callable_proc()