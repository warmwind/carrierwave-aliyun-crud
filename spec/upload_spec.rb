#encoding: utf-8

require File.dirname(__FILE__) + '/spec_helper'

require "open-uri"
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

describe "Upload" do
  def setup_db
    ActiveRecord::Schema.define(:version => 1) do
      create_table :photos do |t|
        t.column :image, :string
      end
      
      create_table :attachments do |t|
        t.column :file, :string
      end
    end
  end
  
  def drop_db
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.drop_table(table)
    end
  end
  
  class PhotoUploader < CarrierWave::Uploader::Base
    CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
    include CarrierWave::MiniMagick

    version :small do
      process :resize_to_fill => [120, 120]
    end
    
    def store_dir
      "photos"
    end
  end
  
  class AttachUploader < CarrierWave::Uploader::Base
    CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
    include CarrierWave::MiniMagick

    def store_dir
      "attachs"
    end
  end

  class Photo < ActiveRecord::Base
    mount_uploader :image, PhotoUploader
  end
  
  class Attachment < ActiveRecord::Base
    mount_uploader :file, AttachUploader
  end
  
  
  before :all do
    setup_db
  end
  
  after :all do
    drop_db
  end
  
  describe "Upload Image" do
    context "should upload image" do
      before(:all) do
        @file = load_file("foo.jpg")
        @file1 = load_file("foo.gif")
        @file2 = load_file("中文图片.jpg")
        @photo = Photo.new(:image => @file)
        @photo1 = Photo.new(:image => @file1)
        @photo2 = Photo.new(:image => @file2)
      end
      
      it "should upload file" do
        @photo.save.should be_true
        @photo1.save.should be_true
        @photo2.save.should be_true
      end
      
      it "should get uploaded file" do
        img = open(@photo.image.url)
        img.size.should == @file.size
        img1 = open(@photo1.image.url)
        img1.size.should == @file1.size
        img2 = open(URI.escape @photo2.image.url)
        img2.size.should == @file2.size
      end

      it "should get small version uploaded file" do
        open(@photo.image.small.url).should_not == nil
        open(@photo1.image.small.url).should_not == nil
        open(URI.escape @photo2.image.small.url).should_not == nil
      end

      it "should delete uploaded files" do
        @photo.remove_image!
        @photo.reload
        expect {open(@photo.image.url)}.to raise_error(OpenURI::HTTPError)
        @photo2.remove_image!
        @photo2.reload
        expect {open(URI.escape @photo2.image.url)}.to raise_error(OpenURI::HTTPError)

      end
    end
    
    context "should update zip" do
      before(:all) do
        @file = load_file("foo.zip")
        @attachment = Attachment.new(:file => @file)
      end
      
      it "should upload file" do
        @attachment.save.should be_true
      end
      
      it "should get uploaded file" do
        attach = open(@attachment.file.url)
        attach.size.should == @file.size
      end
      
    end
  end
end