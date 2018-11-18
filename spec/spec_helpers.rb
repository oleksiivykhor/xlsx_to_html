module SpecHelpers
  def fixture_path(fixture)
    File.expand_path("../fixtures/#{fixture}", __FILE__)
  end

  def fixture(name)
    File.read fixture_path(name)
  end
end
