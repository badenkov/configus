require 'spec_helper'

describe Configus::Builder do
  it "simple one level key value" do
    c = Configus.build :development do
      env :development do
        key :value
      end
    end
    expect(:value).to eq(c.key)
  end

  it "nested key value" do
    c = Configus.build :development do
      env :development do
        key do
          nested_key :value
        end
      end
    end
    expect(:value).to eq(c.key.nested_key)
  end
end
