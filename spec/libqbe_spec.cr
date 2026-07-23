require "./spec_helper"

describe Libqbe do
  it "compile_string" do
    ssa_code = <<-SSA
      export function w $add(w %a, w %b) {
      @start
          %c =w add %a, %b
          ret %c
      }

      export function w $main() {
      @start
          %r =w call $add(w 3, w 4)
          ret %r
      }
    SSA

    Libqbe.compile_string(ssa_code, output: "example.s", target: Libqbe::Target::AMD64_SYSV)
    File.read("./example.s").should contain("movq %rsp, %rbp")
  end

  it "compile_file" do
    Libqbe.compile_file(File.dirname(__FILE__) + "/../test.ssa", output: "example.s", target: Libqbe::Target::AMD64_SYSV)
    File.read("./example.s").should contain("movq %rsp, %rbp")
  end

  it "parse exception" do
    ex = expect_raises(Libqbe::Error, "QBE Error") do
      Libqbe.compile_string("invalid code", output: "example.s")
    end
    ex.filename.should eq "<crystal>"
    ex.line.should eq 1
    ex.column.should eq nil
    ex.error_message.should eq "unknown keyword invalid"
  end

  it "location exception" do
    ssa_code = <<-SSA
      export function w $add(w %a, w %b) {
      @start
          %c = add %a, %b
          ret %c
      }
    SSA

    ex = expect_raises(Libqbe::Error, "QBE Error") do
      Libqbe.compile_string(ssa_code, output: "example.s")
    end

    ex.filename.should eq "<crystal>"
    ex.line.should eq 3
    ex.column.should eq nil
    ex.error_message.should eq "invalid class specifier"
  end
end
