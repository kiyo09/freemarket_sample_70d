FactoryBot.define do
  factory :UserDetail do
    
    user              {"1"}
    first_name        {"name"}
    first_name_kana   {"カタカナ"}
    last_name         {"name"}
    last_name_kana    {"カタカナ"}
    birthday          {"12345678"}
    desination_name   {"name"}
    desination_kana   {"カタカナ"}
    post_code         {"1234567"}
    prefectures       {"神奈川県"}
    mayor             {"横浜市"}
    address           {"日吉"}
    # building          {"ビル"}
    # phone_no          {"09011112222"}
  end
end