# Teapot v2.2.0 configuration generated at 2018-05-10 16:02:38 +1200

required_version "2.0"

# Project Metadata

define_project "coroutine-arm64" do |project|
	project.title = "Coroutine"
	project.license = 'MIT License'
	
	project.add_author 'Samuel Williams', email: 'samuel.williams@oriontransfer.co.nz'
end

# Build Targets

define_target 'coroutine-library-arm64' do |target|
	target.build do
		source_root = target.package.path + 'source'
		copy headers: source_root.glob('Coroutine/**/*.{h,hpp}')
		build static_library: 'Coroutine', source_files: source_root.glob('Coroutine/**/*.{s,cpp}')
	end
	
	target.depends 'Build/Files'
	target.depends 'Build/Clang'
	
	target.depends :platform
	target.depends 'Language/C++14', private: true
	
	target.provides 'Library/Coroutine' do
		append linkflags [
			->{install_prefix + 'lib/libCoroutine.a'},
		]
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
