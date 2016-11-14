class Report < ActiveRecord::Base
    belongs_to :property
    
    #validates_size_of :file, maximum: 1.megabytes, message: "should be less than 1MB"
    validate :file_size_under_two_mb
    
    def initialize(params = {})
        file = params.delete(:file)
        super
        if file
            self.filename = sanitize_filename(file.original_filename)
            self.content_type = file.content_type
            self.file_contents = file.read
        end
    end
    
    private
    
        NUM_BYTES_IN_MEGABYTE = 1048576
        
        def file_size_under_two_mb
            if (self.file_contents.size.to_f / NUM_BYTES_IN_MEGABYTE) > 1
                errors.add(:file, 'File size cannot be over two megabytes.')
            end
        end
    
        def sanitize_filename(filename)
            # Get only the filename, not the whole path (for IE)
            # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
            return File.basename(filename)
        end
end