FactoryBot.define do
  factory :endpoint, class: Endpoint do
    verb { "PUT" }
    path { "/upsert/endpoint" }
    response {{ "code": "200", "body": "", "headers": {} }}
  end
end
