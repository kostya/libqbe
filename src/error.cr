class Libqbe::Error < Exception
  getter filename : String?
  getter line : Int32?
  getter column : Int32?
  getter error_message : String

  def initialize(@error_message : String)
    @filename, @line, @column, @error_message = parse_qbe_error(@error_message)
    super(format_message)
  end

  private def parse_qbe_error(raw : String) : Tuple(String?, Int32?, Int32?, String)
    if raw =~ /^([^:]+):(\d+):(\d+):\s*(.+)$/
      filename = $1
      line = $2.to_i32
      column = $3.to_i32
      message = $4
      {filename, line, column, message}
    elsif raw =~ /^([^:]+):(\d+):\s*(.+)$/
      filename = $1
      line = $2.to_i32
      message = $3
      {filename, line, nil, message}
    else
      {nil, nil, nil, raw}
    end
  end

  private def format_message : String
    if filename && line
      location = "#{filename}:#{line}"
      location += ":#{column}" if column
      "QBE Error at #{location}: #{error_message}"
    else
      "QBE Error: #{error_message}"
    end
  end
end
