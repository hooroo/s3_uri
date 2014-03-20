# encoding: utf-8

require_relative './spec_helper'

describe S3URI do

  let(:s3uri) { S3URI.new(file_name, bucket_name) }

  let(:file_name) { 's3_file' }
  let(:bucket_name) {'s3_bucket'}

  let(:s3_object) { double(AWS::S3) }
  let(:s3_buckets)  { double('s3_buckets') }
  let(:s3_bucket) { double('s3_bucket') }
  let(:s3_files) { double('s3_files') }
  let(:s3_file)   { StringIO.new('s3_file_content') }

  describe 'open' do
    context 'when block given' do
      it 'executes block on s3_file' do
        #the following is very implamentation specific but ensures adherence to AWS::SDK interface
        expect(s3uri).to receive(:s3).and_return(s3_object)
        expect(s3_object).to receive(:buckets).and_return('s3_bucket' => s3_bucket)
        expect(s3_bucket).to receive(:objects).and_return('s3_file' => s3_file)

        expect(s3uri.open {|file| file.read }).to eql('s3_file_content')
      end
    end

    context 'when no block given' do
      it 'returns s3_file' do
        expect(s3uri).to receive(:s3).and_return(s3_object)
        expect(s3_object).to receive(:buckets).and_return('s3_bucket' => s3_bucket)
        expect(s3_bucket).to receive(:objects).and_return('s3_file' => s3_file)

        expect(s3uri.open).to eql(s3_file)
      end
    end
  end

  describe 'to_s' do
    it 'returns the file_name' do
      expect(s3uri.to_s).to eq(file_name)
    end
  end
end
