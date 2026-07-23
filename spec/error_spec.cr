require "./spec_helper"

describe Libqbe::Error do
  it "parses full error format" do
    error = Libqbe::Error.new("test.ssa:5:12: syntax error: expected '}'")
    error.filename.should eq("test.ssa")
    error.line.should eq(5)
    error.column.should eq(12)
    error.error_message.should eq("syntax error: expected '}'")
  end

  it "parses error without column" do
    error = Libqbe::Error.new("test.ssa:3: parse error")
    error.filename.should eq("test.ssa")
    error.line.should eq(3)
    error.column.should be_nil
    error.error_message.should eq("parse error")
  end

  it "handles plain error message" do
    error = Libqbe::Error.new("Unknown error")
    error.filename.should be_nil
    error.line.should be_nil
    error.column.should be_nil
    error.error_message.should eq("Unknown error")
  end
end
