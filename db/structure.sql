SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: generate_snowflake_id(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_snowflake_id() RETURNS bigint
    LANGUAGE plpgsql
    AS $$
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
      $$;


--
-- Name: id_generator(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.id_generator() RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
    our_epoch bigint := 1467327600000;
    seq_id bigint;
    now_millis bigint;
    -- the id of this DB shard, must be set for each
    -- schema shard you have - you could pass this as a parameter too
    shard_id int := 1;
    result bigint:= 0;
BEGIN
    SELECT nextval('public.global_id_seq') % 1024 INTO seq_id;

    SELECT FLOOR(EXTRACT(EPOCH FROM clock_timestamp()) * 1000) INTO now_millis;
    result := (now_millis - our_epoch) << 22;
    result := result | (shard_id << 10);
    result := result | (seq_id);
	return result;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entries (
    uuid uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    authors jsonb DEFAULT '[]'::jsonb,
    contents jsonb,
    contributors jsonb DEFAULT '[]'::jsonb,
    description jsonb,
    enclosures jsonb DEFAULT '[]'::jsonb,
    link character varying(1023),
    published_date timestamp without time zone,
    title character varying(1023),
    updated_date timestamp without time zone,
    url character varying(1023),
    uri character varying(1023),
    readable_content jsonb,
    is_ready boolean DEFAULT false NOT NULL,
    id bigint DEFAULT public.generate_snowflake_id() NOT NULL,
    feed_id bigint
);


--
-- Name: feeds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feeds (
    authors jsonb,
    categories jsonb,
    contributors jsonb,
    copyright character varying(1023),
    description character varying(1023),
    encoding character varying(1023),
    feed_type character varying(1023),
    image character varying(1023),
    language character varying(1023),
    link character varying(1023),
    entry_links jsonb,
    published_date timestamp without time zone,
    title character varying(1023),
    uri character varying(1023),
    feed_uri character varying(1023),
    last_refreshed_at timestamp without time zone DEFAULT now() NOT NULL,
    type character varying,
    scrape_index_news_element_selector character varying,
    scrape_index_headline_selector character varying,
    scrape_index_summary_selector character varying,
    scrape_index_illustration_selector character varying,
    scrape_index_illustration_attribute_name character varying,
    scrape_index_link_selector character varying,
    scrape_index_link_attribute_name character varying,
    scrape_index_link_base character varying,
    scrape_index_date_selector character varying,
    scrape_index_date_format character varying,
    scrape_index_author_selector character varying,
    id bigint DEFAULT public.generate_snowflake_id() NOT NULL,
    use_googlebot_agent boolean DEFAULT true NOT NULL,
    download_content boolean DEFAULT true NOT NULL
);


--
-- Name: global_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.global_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: stream_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stream_assignments (
    id bigint DEFAULT public.generate_snowflake_id() NOT NULL,
    feed_id bigint NOT NULL,
    stream_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: streams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.streams (
    id bigint DEFAULT public.generate_snowflake_id() NOT NULL,
    name character varying,
    permalink character varying,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    "order" integer DEFAULT 0 NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    token character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    email character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    id bigint DEFAULT public.generate_snowflake_id() NOT NULL
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: entries entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT entries_pkey PRIMARY KEY (id);


--
-- Name: feeds feeds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feeds
    ADD CONSTRAINT feeds_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: stream_assignments stream_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stream_assignments
    ADD CONSTRAINT stream_assignments_pkey PRIMARY KEY (id);


--
-- Name: streams streams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.streams
    ADD CONSTRAINT streams_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: entries_published_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX entries_published_date_idx ON public.entries USING btree (published_date);


--
-- Name: entries_uri_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX entries_uri_idx ON public.entries USING btree (uri);


--
-- Name: index_entries_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_entries_on_id ON public.entries USING btree (id);


--
-- Name: index_feeds_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_feeds_on_id ON public.feeds USING btree (id);


--
-- Name: index_stream_assignments_on_feed_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stream_assignments_on_feed_id ON public.stream_assignments USING btree (feed_id);


--
-- Name: index_stream_assignments_on_stream_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stream_assignments_on_stream_id ON public.stream_assignments USING btree (stream_id);


--
-- Name: index_streams_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_streams_on_user_id ON public.streams USING btree (user_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_id ON public.users USING btree (id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: users_token_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_token_idx ON public.users USING btree (token);


--
-- Name: entries fk_rails_05dc0aaac4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT fk_rails_05dc0aaac4 FOREIGN KEY (feed_id) REFERENCES public.feeds(id) ON DELETE SET NULL;


--
-- Name: stream_assignments fk_rails_236c544e6d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stream_assignments
    ADD CONSTRAINT fk_rails_236c544e6d FOREIGN KEY (feed_id) REFERENCES public.feeds(id);


--
-- Name: stream_assignments fk_rails_96bca2d9a8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stream_assignments
    ADD CONSTRAINT fk_rails_96bca2d9a8 FOREIGN KEY (stream_id) REFERENCES public.streams(id);


--
-- Name: streams fk_rails_bb64178f90; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.streams
    ADD CONSTRAINT fk_rails_bb64178f90 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20200906155619'),
('20200906155620'),
('20200906160624'),
('20200906161904'),
('20200906182043'),
('20200906182729'),
('20200906195328'),
('20210201225713'),
('20210201225718'),
('20210201230732'),
('20210207123132'),
('20210207194623'),
('20210207194727'),
('20230110232808'),
('20230110232809'),
('20230110232810'),
('20230115214203'),
('20230115221515'),
('20230115221522'),
('20230115221530'),
('20230115234237'),
('20230115234243'),
('20230115234247'),
('20230118120143'),
('20230212171452'),
('20230219120645'),
('20230219121320'),
('20230219121807'),
('20230219164258'),
('20230219164318'),
('20230624153114'),
('20230626061645');


