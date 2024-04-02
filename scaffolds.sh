docker-compose exec web rails generate scaffold Region name:string code:string:uniq
docker-compose exec web rails generate scaffold District name:string code:string:uniq region:references
docker-compose exec web rails generate scaffold FireDepartment name:string code:string:uniq district:references address:string
docker-compose exec web rails generate scaffold Membership start_date:date fire_department:references account:references role:integer status:integer
docker-compose exec web rails generate scaffold Award name:string award_type:integer image:string dependent_award_id:integer minimum_service_years:integer minimum_age:integer
docker-compose exec web rails generate model AccountAward account:references award:references