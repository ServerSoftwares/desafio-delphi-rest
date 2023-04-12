-- Table: public.cep

-- DROP TABLE public.cep;

CREATE TABLE public.cep
(
    id bigint NOT NULL DEFAULT nextval('cep_id_seq'::regclass),
    cep character varying(10) COLLATE pg_catalog."default" NOT NULL,
    state character varying(2) COLLATE pg_catalog."default",
    city character varying(100) COLLATE pg_catalog."default",
    neighborhood character varying(100) COLLATE pg_catalog."default",
    street character varying(100) COLLATE pg_catalog."default",
    service character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT cep_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.cep
    OWNER to postgres;