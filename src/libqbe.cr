module Libqbe
  VERSION = "0.1.0"

  def self.compile_string(
    ssa_code : String,
    output : String = "-",
    target : Target? = nil,
    debug_flags : String? = nil,
    name : String = "<crystal>",
  )
    compiler = Compiler.new(target: target, output: output, debug_flags: debug_flags)
    begin
      compiler.compile_string(ssa_code, name)
      compiler.finish
    ensure
      compiler.finalize
    end
  end

  def self.compile_file(
    input : String,
    output : String = "-",
    target : Target? = nil,
    debug_flags : String? = nil,
  )
    compiler = Compiler.new(target: target, output: output, debug_flags: debug_flags)
    begin
      compiler.compile_file(input)
      compiler.finish
    ensure
      compiler.finalize
    end
  end
end

require "./*"
