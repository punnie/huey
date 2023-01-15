# typed: false
# frozen_string_literal: true

class CreateSnowflakeIdGeneratorFunction < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE SEQUENCE IF NOT EXISTS public.global_id_seq;

      CREATE OR REPLACE FUNCTION public.generate_snowflake_id()
          RETURNS bigint
          LANGUAGE 'plpgsql'
      AS $BODY$
      DECLARE
          our_epoch bigint := 1314220021721;
          seq_id bigint;
          now_millis bigint;
          -- the id of this DB shard, must be set for each
          -- schema shard you have - you could pass this as a parameter too
          shard_id int := 99;
          result bigint:= 0;
      BEGIN
          SELECT nextval('public.global_id_seq') % 4096 INTO seq_id;
          SELECT FLOOR(EXTRACT(EPOCH FROM clock_timestamp()) * 1000) INTO now_millis;
          result := (now_millis - our_epoch) << 22;
          result := result | (shard_id << 12);
          result := result | (seq_id);
          return result;
      END;
      $BODY$;
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION public.generate_snowflake_id;
      DROP SEQUENCE public.global_id_seq;
    SQL
  end
end
