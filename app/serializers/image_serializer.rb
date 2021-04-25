class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :url, :photographer, :photographer_url, :src, :credit
end
