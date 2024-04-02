docker-compose exec web rails generate scaffold Region name:string code:string
docker-compose exec web rails generate scaffold District name:string code:string region:references
docker-compose exec web rails generate scaffold FireDepartment name:string code:string district:references address:string
docker-compose exec web rails generate scaffold Member full_name:string birth_date:date permanent_address:string email:string phone:string member_code:string role:string
docker-compose exec web rails generate scaffold Membership start_date:date fire_department:references member:references role:string status:string
docker-compose exec web rails generate scaffold Award name:string award_type:string image:string dependent_award_id:integer minimum_service_years:integer minimum_age:integer
