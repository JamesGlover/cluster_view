require 'spec_helper'

describe Image do
  describe_named_scopes do
    def self.mock_batch
      mock_object_with_id('BATCH ID')
    end

    def self.mock_bulk_upload
      mock_object_with_id('BULK UPLOAD ID')
    end
    
    using_named_scope(:for_batch, mock_batch) do
      it_has_conditions('batch_id=?', 'BATCH ID')
      it_has_order('position')
    end
    
    using_named_scope(:by_batch_and_image_id, mock_batch, 'IMAGE ID') do
      it_has_conditions('batch_id=? AND id=?', 'BATCH ID', 'IMAGE ID')
      it_has_order('position')
    end

    using_named_scope(:for_bulk_upload, mock_bulk_upload) do
      it_has_conditions('bulk_upload_id=?', 'BULK UPLOAD ID')
      it_has_order('position')
    end

    using_named_scope(:in_position, :position) do
      it_has_conditions('position=?', :position)
    end
  end

  describe '#root_filename' do
    subject { Image.new(:data_file_name => 'dir1/dir2/data file name.ext').root_filename }

    it 'uses data_file_name for the name of the file' do
      should == 'data file name'
    end
  end
end
