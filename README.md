# libqbe

Crystal bindings for the [QBE](https://c9x.me/compile/) compiler backend. NOTE: Not recommended for use, as I encountered segfaults. QBE heavily relies on global variables, which would cause issues with parallelism. Just use the qbe command directly instead.


## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     libqbe:
       github: kostya/libqbe
   ```

2. Run `shards install`

## Usage

```crystal
require "libqbe"

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

puts "--------------- Compile to file ---------------"
Libqbe.compile_string(ssa_code, output: "example.s")
puts "Generated: "
puts File.read("./example.s")

puts "--------------- Compile to stdout ---------------"
Libqbe.compile_string(ssa_code, target: Libqbe::Target::AMD64_SYSV)

puts "--------------- Compile file ---------------"
Libqbe.compile_file("test.ssa", output: "output.s")

puts "--------------- Exception ---------------"
begin
  Libqbe.compile_string("invalid code")
rescue ex : Libqbe::Error
  p ex
end

puts "--------------- Done ---------------"
```
