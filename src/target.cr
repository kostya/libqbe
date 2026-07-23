enum Libqbe::Target
  AMD64_SYSV
  AMD64_APPLE
  AMD64_WIN
  ARM64
  ARM64_APPLE
  RV64

  def to_c_name : String
    case self
    in .amd64_sysv?  then "amd64_sysv"
    in .amd64_apple? then "amd64_apple"
    in .amd64_win?   then "amd64_win"
    in .arm64?       then "arm64"
    in .arm64_apple? then "arm64_apple"
    in .rv64?        then "rv64"
    end
  end

  def self.native : Target
    {% if flag?(:darwin) %}
      {% if flag?(:aarch64) %}
        ARM64_APPLE
      {% else %}
        AMD64_APPLE
      {% end %}
    {% elsif flag?(:linux) || flag?(:bsd) %}
      {% if flag?(:aarch64) %}
        ARM64
      {% elsif flag?(:riscv64) %}
        RV64
      {% else %}
        AMD64_SYSV
      {% end %}
    {% elsif flag?(:win32) || flag?(:win64) %}
      AMD64_WIN
    {% else %}
      {% raise "Unable to determine native target for this platform" %}
    {% end %}
  end
end
