-- public.pdi_logging definition

-- Drop table

-- DROP TABLE public.pdi_logging;

set search_path = ${DATABASE_LOG_SCHEMA};

CREATE TABLE IF NOT EXISTS pdi_logging (
	channel_id varchar(255) NULL,
	lines_read int8 NULL,
	lines_written int8 NULL,
	lines_updated int8 NULL,
	lines_input int8 NULL,
	lines_output int8 NULL,
	lines_rejected int8 NULL,
	errors int8 NULL,
	id_job int4 NULL,
	jobname varchar(255) NULL,
	status varchar(15) NULL,
	startdate timestamp NULL,
	enddate timestamp NULL,
	logdate timestamp NULL,
	depdate timestamp NULL,
	replaydate timestamp NULL,
	log_field text NULL,
	id_batch int4 NULL,
	log_date timestamp NULL,
	logging_object_type varchar(255) NULL,
	object_name varchar(255) NULL,
	object_copy varchar(255) NULL,
	repository_directory varchar(255) NULL,
	filename varchar(255) NULL,
	object_id varchar(255) NULL,
	object_revision varchar(255) NULL,
	parent_channel_id varchar(255) NULL,
	root_channel_id varchar(255) NULL,
	transname varchar(255) NULL,
	stepname varchar(255) NULL,
	RESULT bool NULL,
	nr_result_rows int8 NULL,
	nr_result_files int8 NULL,
	metrics_date timestamp NULL,
	metrics_code varchar(255) NULL,
	metrics_description varchar(255) NULL,
	metrics_subject varchar(255) NULL,
	metrics_type varchar(255) NULL,
	metrics_value int8 NULL,
	seq_nr int4 NULL,
	step_copy int4 NULL,
	input_buffer_rows int8 NULL,
	output_buffer_rows int8 NULL,
	RESULT varchar(5) NULL,
	step_copy int4 NULL,
	executing_server varchar(255) NULL,
	executing_user varchar(255) NULL,
	client varchar(255) NULL
);
CREATE INDEX IF NOT EXISTS IDX_NULL_2 ON public.pdi_logging USING btree (transname, log_date);
CREATE INDEX IF NOT EXISTS idx_pdi_logging_1 ON public.pdi_logging USING btree (id_job);
CREATE INDEX IF NOT EXISTS idx_pdi_logging_2 ON public.pdi_logging USING btree (errors, status, jobname);
CREATE INDEX IF NOT EXISTS idx_pdi_logging_3 ON public.pdi_logging USING btree (transname, logdate);
