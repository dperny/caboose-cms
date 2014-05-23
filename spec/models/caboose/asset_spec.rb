require 'spec_helper'

module Caboose
  describe Asset do

    it "should #sanitize_name" do
      expect(subject.sanitize_name("Some File Name")).to eq("some_file_name")
    end

    it "should get assets with uris" do
      pending "what does this do"
    end

  end
end
