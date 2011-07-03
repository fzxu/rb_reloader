require "rb_reloader/version"

module RbReloader
  class FileWatcher < Array
    attr_reader :file, :mtime
    @map ||= {}
    
    def self.new(file)
      @map[file] ||= super      
    end

    class << self
      alias [] new
    end
    
    def self.each(&block)
      @map.values.each(&block) 
    end
    
    def initialize(file)
      @reload, @file = true, file
      @mtime = File.exist?(file) ? File.mtime(file) : Time.at(0)
      super()
    end

    def reload?
      @reload and changed?
    end

    def changed?
      !File.exist? file or @mtime != File.mtime(file)
    end

    def reload
      reload! if reload?
    end

    def reload!
      $LOADED_FEATURES.delete file
      clear
      if File.exist? file
        @mtime = File.mtime(file)
        require file
      end
    end        
  end
  
  class << self
    def register(files = [])
      files.flatten.each do |file|
        # Rubinius and JRuby ignore block passed to glob.
        Dir.glob(file).each { |f| FileWatcher[f] }
        #FileWatcher[file]
      end
    end
      
    def reload
      FileWatcher.each {|x| x.reload}
    end
    
    def registered_rb
      files = []
      FileWatcher.each {|x| files << x.file }
      files
    end
  end
end
