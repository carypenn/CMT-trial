class NpiRecord < ApplicationRecord
  self.inheritance_column = :_type_disabled
  default_scope { order("created_at desc") }

  def self.build(data)
    puts data.to_s
    return nil if data["result_count"] == 0
    npi = data["results"].first
    return NpiRecord.new({
         number: npi["number"],
         name: build_name(npi["basic"]),
         address: build_address(npi["addresses"]),
         type: npi["enumeration_type"],
         taxonomy: build_taxonomy(npi["taxonomies"])
    })
  end

  private
  class << self
    def build_name(basic)
      "#{basic["name_prefix"]} #{basic["first_name"]} #{basic["middle_name"]} #{basic["last_name"]} #{basic["name_suffix"]}"
    end

    def build_address(addresses)
      address = addresses.select { |a| a["address_purpose"] == "LOCATION" }.first
      "#{address["address_1"]} #{address["address_2"]} #{address["city"]}, #{address["state"]}, #{address["country_name"]}  #{address["postal_code"]}"
    end

    def build_taxonomy(taxonomies)
      taxonomy = taxonomies.select { |t| t["primary"] == true }.first
      "#{taxonomy["code"]} #{taxonomy["desc"]} #{taxonomy["state"]} #{taxonomy["license"]}"
    end
  end
end

# {
#   "result_count"=>1,
#   "results"=>[
#     {
#       "enumeration_type"=>"NPI-1",
#       "number"=>1215027263,
#       "last_updated_epoch"=>1552052010,
#       "created_epoch"=>1160697600,
#       "basic"=>{
#         "name_prefix"=>"DR.",
#         "first_name"=>"WEEMS",
#         "last_name"=>"PENNINGTON",
#         "middle_name"=>"R",
#         "name_suffix"=>"III",
#         "credential"=>"MD",
#         "sole_proprietor"=>"NO",
#         "gender"=>"M",
#         "enumeration_date"=>"2006-10-13",
#         "last_updated"=>"2019-03-08",
#         "status"=>"A",
#         "name"=>"PENNINGTON WEEMS"
#         },
#         "other_names"=>[],
#         "addresses"=>[
#           {
#             "country_code"=>"US",
#             "country_name"=>"United States",
#             "address_purpose"=>"LOCATION",
#             "address_type"=>"DOM",
#             "address_1"=>"137 MIRACLE DR",
#             "address_2"=>"",
#             "city"=>"AIKEN",
#             "state"=>"SC",
#             "postal_code"=>"298016351",
#             "telephone_number"=>"803-641-4874",
#             "fax_number"=>"803-641-0436"
#           },
#           {
#             "country_code"=>"US",
#             "country_name"=>"United States",
#             "address_purpose"=>"MAILING",
#             "address_type"=>"DOM",
#             "address_1"=>"367 S. GULPH RD",
#             "address_2"=>"ATT: IPM CREDENTIALING",
#             "city"=>"KING OF PRUSSIA",
#             "state"=>"PA",
#             "postal_code"=>"194063121",
#             "telephone_number"=>"803-641-4874"
#           }
#         ],
#         "taxonomies"=>[
#           {
#             "code"=>"207RC0000X",
#             "desc"=>"Internal Medicine Cardiovascular Disease",
#             "primary"=>true,
#             "state"=>"SC",
#             "license"=>"22253"
#           },
#           {
#             "code"=>"207RC0000X",
#             "desc"=>"Internal Medicine Cardiovascular Disease",
#             "primary"=>false,
#             "state"=>"GA",
#             "license"=>"59309"
#           }
#         ],
#         "identifiers"=>[
#           {
#             "identifier"=>"G59309",
#             "code"=>"05",
#             "desc"=>"MEDICAID",
#             "state"=>"SC",
#             "issuer"=>""
#           }
#         ]
#       }
#     ]
#   }
