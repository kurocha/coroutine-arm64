# Teapot v2.2.0 configuration generated at 2018-05-10 16:02:38 +1200

required_version "2.0"

# Project Metadata

define_project "coroutine-arm64" do |project|
	project.title = "Coroutine"
	project.license = 'MIT License'
	
	project.add_author 'Samuel Williams', email: 'samuel.williams@oriontransfer.co.nz'
end

# Build Targets

define_target 'coroutine-library-amd64' do |target|
	target.depends 'Language/C++14'
	
	target.provides 'Library/Coroutine' do
		source_root = target.package.path + 'source'
		
		library_path = build static_library: 'Coroutine', source_files: source_root.glob('Coroutine/**/*.{s,cpp}')

		append linkflags library_path
		append header_search_paths source_root
	end
end

# Configurations

define_configuration 'development' do |configuration|
	configuration[:source] = "https://github.com/kurocha/"
	
	# Provides all the build related infrastructure:
	configuration.require 'platforms'
	
	# Provides some useful C++ generators:
	configuration.require 'generate-cpp-class'
	
	configuration.require "generate-project"
	configuration.require "generate-travis"
end
