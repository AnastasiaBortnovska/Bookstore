require "image_processing/mini_magick"

class ImageUploader < Shrine

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    { 
      small:  magick.resize_to_limit!(160, 190),
      medium: magick.resize_to_limit!(250, 310),
      large:  magick.resize_to_limit!(555, 380),
      for_images:  magick.resize_to_limit!(170, 120),
    }
  end
  
  Attacher.default_url do |**options|
    "https://bookstore-bortnovska.s3.eu-central-1.amazonaws.com/default.jpg?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEAUaCWV1LXdlc3QtMiJGMEQCIGAIBMn4B3g0GyTOGUkJ82zXAKJ0wpr6UBwpwdN7EqhPAiAKe6f52jlDFEG%2BrogEFNV%2FpbhQKgttDV1VoVUBgRDFqyr%2FAgje%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAAaDDcxMTkxNzU3OTUyOCIMjBZOdn0208eWqruHKtMCy79FruSDaq447fVZPSni%2F0zgBzZ7%2B2QJhEaX4USc3hXnXVgmtSlSxulHwR40hZ1N5iCMh6COWaT%2FLtoDHik5drGO%2FF%2FSaQsQKUZKtm8vcrk7J%2FGl0qb4OS8HEcWrK4j2wgcXVm36jzBI7MH8caK49CXs393d8DtVqVelyIY9dN%2FXF8rO5zQB0ENwaZE0I4tC%2FxD%2BctbmW3Ao7isq5UmhrXsLM2TPTvjEovsPZ3vyt50lILRaF1cbU3Hin4PZO3u1KN3JkdhRCmKE5Y08JtdbMUCiryqyCO3%2BEgAyQcsw2WRl1D4mVhlIiQXYltIi2QQg8uBpCNGdzHFzDFAIOHiyfmeE3HLOmVQNou8S%2FQxsorqtYtkcxSUm%2F%2BxL4VO4XQCChGwgB0wwNNjV6%2FZRBGnsgs42G%2F9MRStOaF6E6fNkSyGRMYgXP%2Fbw4%2FRMghEsTcbO2dmBMM3s%2FYYGOrQClfwBOf153Xby8pYB7V6k6p0EB%2FO%2FPua9P4cjwR1CLzhOcg5AIhUjOptl2jI%2BnanXTZLFYTHiLfZSPmSW3icdTTXsFu2RndfUKyilT%2FGfgAVeck%2BtZQf35LP%2BuNiZakYtQxh49IHEUJRMrLCsHht%2BzOVUANJ%2BCIXKLiQl3t9M2%2FzHnJhm6yVjT4OZQMjM%2Bc7wb6FrWy1mpr4oN%2FoQVuLuwmgf9egECFRRbwhuZixloByYDDROqGHXULU72uY7vrlFNUeRrs%2F5ptDJSMGNsNlcUlTw1Z1KBQx2tYsStxEdOGxT4eVccwUtzvLfLKTHsvBoa0vutX4eE3m0Xul3kRtoOPosEOD%2FyNLQqvk8OwrCLMmqJ2%2FdIb2BShZyyI8UP6uJct2nylOCCkaSTwzBLUJOtjTeO2Q%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20210702T204028Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIA2LQMYFUEIYNAUFRQ%2F20210702%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Signature=4e1e5895c1f31dfd8f336be8ab00ccdccedc0fa6bfd5ae0c8bedd48b5c56350c"
  end
end
