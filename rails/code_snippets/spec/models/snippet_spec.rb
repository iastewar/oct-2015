require "rails_helper"

describe Snippet do
  describe "validations" do
    describe "kind" do
      it "must be present" do
        expect(Snippet.new(title: "asdf").validate).to be(false)
      end
    end
    describe "title" do
      it "must be present" do
        expect(Snippet.new(kind:"sdf").validate).to be(false)
      end
      it "must be unique" do
        title = "fd"
        Snippet.create(title: title)
        expect(Snippet.new(title: title).validate).to be(false)
      end
    end
  end
end
