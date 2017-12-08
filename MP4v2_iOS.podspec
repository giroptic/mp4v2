Pod::Spec.new do |s|
  s.name      = 'MP4v2_iOS'
  s.version   = '2.1.0'
  s.summary   = "MP4v2 is a C/C++ framework to manipulate or create MP4 files."
  s.homepage  = 'http://www.giroptic.com'
  s.license   = { :type => 'MOZILLA', :file => 'COPYING' }
  s.platform  = :ios
  s.authors   = { 'GIROPTIC' => 'support@giroptic.com' }
  s.source           = { :git => 'https://github.com/giroptic/mp4v2.git', :branch => 'develop' }
  s.source_files = \
  'src/*.cpp', \
  'src/**/*.cpp', \
  'include/mp4v2/chapter.h', \
  'include/mp4v2/file_prop.h', \
  'include/mp4v2/file.h', \
  'include/mp4v2/general.h', \
  'include/mp4v2/isma.h', \
  'include/mp4v2/itmf_generic.h', \
  'include/mp4v2/itmf_tags.h', \
  'ios/MP4v2_iOS.h', \
  'include/mp4v2/platform.h', \
  'include/mp4v2/sample.h', \
  'include/mp4v2/streaming.h', \
  'include/mp4v2/track_prop.h', \
  'include/mp4v2/track.h', \
  'libplatform/io/File.cpp', \
  'libplatform/io/File_posix.cpp', \
  'libplatform/io/FileSystem.cpp', \
  'libplatform/io/FileSystem_posix.cpp', \
  'libplatform/number/random_posix.cpp', \
  'libplatform/process/process_posix.cpp', \
  'libplatform/prog/option.cpp', \
  'libplatform/sys/error.cpp', \
  'libplatform/time/time.cpp', \
  'libplatform/time/time_posix.cpp'
  s.public_header_files = \
  'include/mp4v2/chapter.h', \
  'include/mp4v2/file_prop.h', \
  'include/mp4v2/file.h', \
  'include/mp4v2/general.h', \
  'include/mp4v2/isma.h', \
  'include/mp4v2/itmf_generic.h', \
  'include/mp4v2/itmf_tags.h', \
  'ios/MP4v2_iOS.h', \
  'include/mp4v2/platform.h', \
  'include/mp4v2/sample.h', \
  'include/mp4v2/streaming.h', \
  'include/mp4v2/track_prop.h', \
  'include/mp4v2/track.h'
  s.ios.deployment_target = '8.0'
  s.libraries = 'c++'
  s.requires_arc = true
  s.preserve_paths = 'src/*.{h,tcc}', 'src/**/*.h', 'libplatform/*.h', 'libplatform/**/*.h', 'include/mp4v2/*.h'
  s.xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++98',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'HEADER_SEARCH_PATHS' => '$(PODS_TARGET_SRCROOT) $(PODS_TARGET_SRCROOT)/include'
  }
  s.prepare_command = <<-CMD
    cp -f ios/project.h include/mp4v2/project.h && cp -f ios/config.h libplatform/config.h;
  CMD
end
