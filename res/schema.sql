--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cases (
    uuid character varying(50) NOT NULL,
    submittime timestamp with time zone NOT NULL,
    sha256 text,
    fname text,
    status text NOT NULL,
    vm_uuid character varying(50),
    starttime timestamp with time zone,
    endtime timestamp with time zone,
    interactive boolean,
    reboots integer,
    banking boolean,
    web boolean,
    vm_os text,
    runtime integer
);


ALTER TABLE cases OWNER TO postgres;

--
-- Name: suspects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE suspects (
    sha256 text NOT NULL,
    sha1 text,
    md5 text,
    originalname text,
    magic text,
    avresult text,
    uploadtime timestamp with time zone
);


ALTER TABLE suspects OWNER TO postgres;

--
-- Name: victims; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE victims (
    libvirtname character varying(100),
    uuid character varying(50) NOT NULL,
    hostname text,
    os text,
    ip text,
    username text,
    password text,
    diskfile text,
    status text,
    runcounter integer,
    last_reboot timestamp without time zone
);


ALTER TABLE victims OWNER TO postgres;

--
-- Name: workerstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE workerstate (
    id integer,
    pid integer NOT NULL,
    uuid character varying(50) NOT NULL,
    "position" character varying(50) NOT NULL,
    params text,
    job_uuid character varying(50)
);


ALTER TABLE workerstate OWNER TO postgres;

--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (uuid);


--
-- Name: suspects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY suspects
    ADD CONSTRAINT suspects_pkey PRIMARY KEY (sha256);


--
-- Name: victims_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY victims
    ADD CONSTRAINT victims_pkey PRIMARY KEY (uuid);


--
-- Name: workerstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workerstate
    ADD CONSTRAINT workerstate_pkey PRIMARY KEY (uuid);


--
-- Name: cases_sha256_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_sha256_fkey FOREIGN KEY (sha256) REFERENCES suspects(sha256);


--
-- Name: workerstate_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workerstate
    ADD CONSTRAINT workerstate_uuid_fkey FOREIGN KEY (uuid) REFERENCES victims(uuid);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: cases; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE cases FROM PUBLIC;
REVOKE ALL ON TABLE cases FROM postgres;
GRANT ALL ON TABLE cases TO postgres;
GRANT ALL ON TABLE cases TO hexlab;


--
-- Name: suspects; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE suspects FROM PUBLIC;
REVOKE ALL ON TABLE suspects FROM postgres;
GRANT ALL ON TABLE suspects TO postgres;
GRANT ALL ON TABLE suspects TO hexlab;


--
-- Name: victims; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE victims FROM PUBLIC;
REVOKE ALL ON TABLE victims FROM postgres;
GRANT ALL ON TABLE victims TO postgres;
GRANT ALL ON TABLE victims TO hexlab;


--
-- Name: workerstate; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE workerstate FROM PUBLIC;
REVOKE ALL ON TABLE workerstate FROM postgres;
GRANT ALL ON TABLE workerstate TO postgres;
GRANT ALL ON TABLE workerstate TO hexlab;


--
-- PostgreSQL database dump complete
--

