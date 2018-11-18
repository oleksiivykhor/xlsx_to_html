FactoryBot.define do
  headers = %w[Test Test1 Test2]
  rows = [[1, 10, 19], [2, 11, 20], [3, 12, 21], [4, 13, 22], [5, 14, 23],
          [6, 15, 24], [7, 16, 25], [8, 17, 26], [9, 18, 27]]

  factory :expected_data, class: Hash do
    headers { headers }
    rows { rows }
  end

  factory :without_headers_data, class: Hash do
    headers { [] }
    rows { rows }
  end

  initialize_with { attributes }
end
