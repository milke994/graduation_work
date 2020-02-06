CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "full_name" varchar,
  "user_type" varchar,
  "email" varchar,
  "password" varchar,
  "phone_number" varchar,
  "first_login" int
);

CREATE TABLE "appointments" (
  "id" SERIAL PRIMARY KEY,
  "vet_id" int,
  "pet_owner_id" int,
  "pet_id" int,
  "status" varchar,
  "time" timestamp
);

CREATE TABLE "pets" (
  "id" SERIAL PRIMARY KEY,
  "owner" int,
  "pet_info_id" int,
  "medical_info_id" int,
  "pet_profile_picture" int,
  "name" varchar,
  "feeding_habits" varchar,
  "species" varchar,
  "breed" varchar,
  "age" int,
  "weight" float
);

CREATE TABLE "pet_info" (
  "id" SERIAL PRIMARY KEY,
  "indoor" varchar,
  "food_type" varchar,
  "meal_size" varchar,
  "meals_per_day" int,
  "physical_activity" varchar,
  "traveling" varchar
);

CREATE TABLE "medical_info" (
  "id" SERIAL PRIMARY KEY,
  "allergies" varchar,
  "diseases" varchar,
  "treatments" varchar
);

CREATE TABLE "measurements" (
  "id" SERIAL PRIMARY KEY,
  "pet_id" int,
  "measure" float,
  "time" timestamp
);

CREATE TABLE "photos" (
  "id" SERIAL PRIMARY KEY,
  "pet_id" int,
  "photo" bytea
);

CREATE TABLE "medical_files" (
  "id" SERIAL PRIMARY KEY,
  "pet_id" int,
  "createor" int,
  "stats" varchar,
  "vaccination" varchar,
  "medicine" varchar,
  "lab_results" varchar,
  "report" varchar
);

ALTER TABLE "medical_files" ADD FOREIGN KEY ("createor") REFERENCES "users" ("id");

ALTER TABLE "medical_files" ADD FOREIGN KEY ("pet_id") REFERENCES "pets" ("id");

ALTER TABLE "photos" ADD FOREIGN KEY ("pet_id") REFERENCES "pets" ("id");

ALTER TABLE "pets" ADD FOREIGN KEY ("owner") REFERENCES "users" ("id");

ALTER TABLE "pets" ADD FOREIGN KEY ("pet_profile_picture") REFERENCES "photos" ("id");

ALTER TABLE "pets" ADD FOREIGN KEY ("pet_info_id") REFERENCES "pet_info" ("id");

ALTER TABLE "pets" ADD FOREIGN KEY ("medical_info_id") REFERENCES "medical_info" ("id");

ALTER TABLE "appointments" ADD FOREIGN KEY ("vet_id") REFERENCES "users" ("id");

ALTER TABLE "appointments" ADD FOREIGN KEY ("pet_owner_id") REFERENCES "users" ("id");

ALTER TABLE "measurements" ADD FOREIGN KEY ("pet_id") REFERENCES "pets" ("id");