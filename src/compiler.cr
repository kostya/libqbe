class Libqbe::Compiler
  getter ctx : Libqbe::Lib::QBEContext
  property output : String
  property debug_flags : String?

  def initialize(
    @target : Target? = nil,
    @output : String = "-",
    @debug_flags : String? = nil,
  )
    @ctx = Libqbe::Lib.qbe_new
    raise Error.new("Failed to create QBE context") if @ctx.null?

    if Libqbe::Lib.qbe_init_defaults(@ctx) != 0
      Libqbe::Lib.qbe_free(@ctx)
      raise Error.new("Failed to initialize QBE context")
    end

    if t = @target
      set_target(t)
    end

    set_output(@output)
    if flags = @debug_flags
      set_debug_flags(flags)
    end
  end

  def set_target(target : Target) : self
    @target = target
    ret = Libqbe::Lib.qbe_set_target(@ctx, target.to_c_name)
    raise Error.new(get_error) if ret != 0
    self
  end

  def set_output(filename : String) : self
    @output = filename
    ret = Libqbe::Lib.qbe_set_output_file(@ctx, filename)
    raise Error.new(get_error) if ret != 0
    self
  end

  def set_debug_flags(flags : String) : self
    @debug_flags = flags
    Libqbe::Lib.qbe_set_debug_flags(@ctx, flags)
    self
  end

  def compile_string(ssa_code : String, name : String = "<crystal>") : self
    ret = Libqbe::Lib.qbe_compile_string(@ctx, ssa_code, name)
    raise Error.new(get_error) if ret != 0
    self
  end

  def compile_file(filename : String) : self
    ret = Libqbe::Lib.qbe_compile_file(@ctx, filename)
    raise Error.new(get_error) if ret != 0
    self
  end

  def finish : self
    ret = Libqbe::Lib.qbe_finish(@ctx)
    raise Error.new(get_error) if ret != 0
    self
  end

  private def get_error : String
    err = Libqbe::Lib.qbe_get_error(@ctx)
    err.null? ? "Unknown QBE error" : String.new(err)
  end

  def finalize
    if @ctx && !@ctx.null?
      Libqbe::Lib.qbe_free(@ctx)
    end
  end
end
