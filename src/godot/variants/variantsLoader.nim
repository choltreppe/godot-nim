# ======================================== #
# This module was generated automatically. #
# Edits will be lost.                      #
# ======================================== #
import ./../godotInterface
import ./../logging
import ./variantsConstr_custom
import ./variantsConstr_native
import ./variantsDetail_custom
import ./variantsDetail_native

proc load_Variants* =
  let me = iam("load-Variants", stgLibrary)
  me.debug "load destructors of all variants..."
  load_Variants_destr()
  me.debug "load constructors of all variants..."
  load_String_constr()
  load_Rect2_constr()
  load_Rect2i_constr()
  load_Transform2D_constr()
  load_Plane_constr()
  load_Quaternion_constr()
  load_AABB_constr()
  load_Basis_constr()
  load_Transform3D_constr()
  load_Projection_constr()
  load_Color_constr()
  load_StringName_constr()
  load_NodePath_constr()
  load_RID_constr()
  load_Callable_constr()
  load_Signal_constr()
  load_Dictionary_constr()
  load_Array_constr()
  load_PackedByteArray_constr()
  load_PackedInt32Array_constr()
  load_PackedInt64Array_constr()
  load_PackedFloat32Array_constr()
  load_PackedFloat64Array_constr()
  load_PackedStringArray_constr()
  load_PackedVector2Array_constr()
  load_PackedVector3Array_constr()
  load_PackedColorArray_constr()
  me.debug "load functions of all variants..."
  load_String_allmethod()
  load_Rect2_allmethod()
  load_Rect2i_allmethod()
  load_Transform2D_allmethod()
  load_Plane_allmethod()
  load_Quaternion_allmethod()
  load_AABB_allmethod()
  load_Basis_allmethod()
  load_Transform3D_allmethod()
  load_Projection_allmethod()
  load_Color_allmethod()
  load_StringName_allmethod()
  load_NodePath_allmethod()
  load_RID_allmethod()
  load_Callable_allmethod()
  load_Signal_allmethod()
  load_Dictionary_allmethod()
  load_Array_allmethod()
  load_PackedByteArray_allmethod()
  load_PackedInt32Array_allmethod()
  load_PackedInt64Array_allmethod()
  load_PackedFloat32Array_allmethod()
  load_PackedFloat64Array_allmethod()
  load_PackedStringArray_allmethod()
  load_PackedVector2Array_allmethod()
  load_PackedVector3Array_allmethod()
  load_PackedColorArray_allmethod()
  me.debug "load tuned functions of all variants..."
  load_vectors()
  load_primitives()