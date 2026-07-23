@[Link(ldflags: "#{__DIR__}/ext/qbe-c/libqbe.a")]
lib Libqbe::Lib
  type QBEContext = Void*

  fun qbe_new : QBEContext
  fun qbe_free(q : QBEContext)
  fun qbe_init_defaults(q : QBEContext) : Int32
  fun qbe_set_target(q : QBEContext, target_name : LibC::Char*) : Int32
  fun qbe_set_output_file(q : QBEContext, filename : LibC::Char*) : Int32
  fun qbe_set_debug_flags(q : QBEContext, flags : LibC::Char*)
  fun qbe_compile_string(q : QBEContext, input : LibC::Char*, name : LibC::Char*) : Int32
  fun qbe_compile_file(q : QBEContext, filename : LibC::Char*) : Int32
  fun qbe_compile_stream(q : QBEContext, stream : Void*, name : LibC::Char*) : Int32
  fun qbe_finish(q : QBEContext) : Int32
  fun qbe_get_error(q : QBEContext) : LibC::Char*
  fun qbe_target_count : Int32
  fun qbe_target_name(index : Int32) : LibC::Char*
end
