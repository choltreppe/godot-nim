# ======================================== #
# This module was generated automatically. #
# Edits will be lost.                      #
# ======================================== #
import ./../helper/engineClassDefiner
import ./classDetail_native_CSGPrimitive3D; export classDetail_native_CSGPrimitive3D

proc `mesh=`*(self: CSGMesh3D; mesh: Mesh) =
  var methodbind {.global.}: MethodBindPtr
  if unlikely(methodbind.isNil):
    let name = api.newStringName "set_mesh"
    methodbind = interface_ClassDB_getMethodBind(addr className CSGMesh3D, addr name, 194775623)
  var `?param` = [getPtr mesh]
  interface_Object_methodBindPtrCall(methodbind, getOwner self, addr `?param`[0], nil)
proc mesh*(self: CSGMesh3D): Mesh =
  var methodbind {.global.}: MethodBindPtr
  if unlikely(methodbind.isNil):
    let name = api.newStringName "get_mesh"
    methodbind = interface_ClassDB_getMethodBind(addr className CSGMesh3D, addr name, 4081188045)
  var ret: encoded Mesh
  interface_Object_methodBindPtrCall(methodbind, getOwner self, nil, addr ret)
  (addr ret).decode_result(Mesh)
proc `material=`*(self: CSGMesh3D; material: Material) =
  var methodbind {.global.}: MethodBindPtr
  if unlikely(methodbind.isNil):
    let name = api.newStringName "set_material"
    methodbind = interface_ClassDB_getMethodBind(addr className CSGMesh3D, addr name, 2757459619)
  var `?param` = [getPtr material]
  interface_Object_methodBindPtrCall(methodbind, getOwner self, addr `?param`[0], nil)
proc material*(self: CSGMesh3D): Material =
  var methodbind {.global.}: MethodBindPtr
  if unlikely(methodbind.isNil):
    let name = api.newStringName "get_material"
    methodbind = interface_ClassDB_getMethodBind(addr className CSGMesh3D, addr name, 5934680)
  var ret: encoded Material
  interface_Object_methodBindPtrCall(methodbind, getOwner self, nil, addr ret)
  (addr ret).decode_result(Material)