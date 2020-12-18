require 'mkmf-rice'

extension_name = 'express_parser'
dir_config(extension_name)

have_library('stdc++')

$CFLAGS << ' -std=c++14'

include_paths = [
  '.',
  'antlrgen',
  'antlr4-upstream/runtime/Cpp/runtime/src',
  'antlr4-upstream/runtime/Cpp/runtime/src/atn',
  'antlr4-upstream/runtime/Cpp/runtime/src/dfa',
  'antlr4-upstream/runtime/Cpp/runtime/src/misc',
  'antlr4-upstream/runtime/Cpp/runtime/src/support',
  'antlr4-upstream/runtime/Cpp/runtime/src/tree',
  'antlr4-upstream/runtime/Cpp/runtime/src/tree/pattern',
  'antlr4-upstream/runtime/Cpp/runtime/src/tree/xpath'
]

$srcs = []

include_paths.each do |include_path|
  $INCFLAGS << " -I#{__dir__}/#{include_path}"
  $VPATH << "#{__dir__}/#{include_path}"

  Dir.glob("#{__dir__}/#{include_path}/*.cpp").each do |path|
    $srcs << path
  end
end

create_makefile(extension_name)