--   -------------------------------------------------- 
--   Generated by Enterprise Architect Version 8.0.864
--   Created On : Wednesday, 16 May, 2012 
--   DBMS       : MySql 
--   -------------------------------------------------- 



--  Drop Tables, Stored Procedures and Views 

DROP TABLE Class1
;
DROP TABLE IF EXISTS access_right
;
DROP TABLE IF EXISTS age_limit
;
DROP TABLE IF EXISTS ban_reason
;
DROP TABLE IF EXISTS comment
;
DROP TABLE IF EXISTS download_intensity
;
DROP TABLE IF EXISTS download_link
;
DROP TABLE IF EXISTS file
;
DROP TABLE IF EXISTS file_category
;
DROP TABLE IF EXISTS file_m2m_user
;
DROP TABLE IF EXISTS file_m2m_user_group
;
DROP TABLE IF EXISTS ip_blacklist
;
DROP TABLE IF EXISTS log
;
DROP TABLE IF EXISTS log_archive
;
DROP TABLE IF EXISTS page
;
DROP TABLE IF EXISTS resource_info
;
DROP TABLE IF EXISTS user
;
DROP TABLE IF EXISTS user_group
;
DROP TABLE IF EXISTS user_group_m2m_user
;
DROP TABLE IF EXISTS user_role
;
DROP TABLE IF EXISTS user_role_m2m_user
;
DROP TABLE IF EXISTS user_role_m2m_user_role_right
;
DROP TABLE IF EXISTS user_role_right
;

--  Create Tables 

;

CREATE TABLE access_right
(
	ar_uid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� ���������.',
	ar_name VARCHAR(255) NULL COMMENT '������������ ��������� (� �.�. ����� ���������� ������������� ��������������, ����� ������������ ���� ar_user_created).',
	ar_description TEXT NULL COMMENT '�������� ���������.',
	ar_u_uid BIGINT UNSIGNED NULL COMMENT '��� �� ������������� ������ �����. NULL == ����������������� �����.',
	PRIMARY KEY (ar_uid),
	UNIQUE UQ_access_right_ar_uid(ar_uid),
	KEY (ar_u_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='��������� ������� � �����. ��������, "���������", "������", "��� ������", "��� ���������� ����� �������������". ������������ ����� ��������� ���� ������ ���� �������.'
;


CREATE TABLE age_limit
(
	al_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� �����������.',
	al_min_age SMALLINT UNSIGNED NOT NULL COMMENT '����������� ������� (X+), �� ������� ��� �� ���������������� ����������� (��������: 18 -- ������, ��� ����������� ���������������� �� ���, ���� �� 0 �� 17 ������������ ���.',
	al_name VARCHAR(255) NOT NULL COMMENT '������������ ����������� -- TBD, ��. ������������� �������� �� ���������� �������, ��� � �.�. �� ����� ���� 2+ ���������� �����������!',
	al_description TEXT NULL COMMENT '�������� ����������� (��������: "�������� �������� ������ ����������, �� ��� ����� �� 3-� ���!")',
	PRIMARY KEY (al_id),
	UNIQUE UQ_age_limit_al_id(al_id),
	UNIQUE UQ_age_limit_al_name(al_name)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='���������� �����������. ������������ ����������� -- TBD, ��. ������������� �������� �� ���������� �������, ��� � �.�.'
;


CREATE TABLE ban_reason
(
	br_uid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� ������� ����.',
	br_name VARCHAR(180) NULL COMMENT '�������� ������� ���� (���������, ������ 180 ��������;  MySQL �� ���������� ����� ������ � UTF8 � ���������� ��������).',
	br_description TEXT NULL COMMENT '�������� ������� ����.',
	PRIMARY KEY (br_uid),
	UNIQUE UQ_ban_reason_br_name(br_name)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='������� ����.'
;


CREATE TABLE comment
(
	c_uid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� �����������.',
	c_f_uid BIGINT UNSIGNED NOT NULL COMMENT '� ������ ����� ��������� ����������� (������ �� ������� ������).',
	c_text TEXT NOT NULL COMMENT '����� �����������.',
	c_u_uid BIGINT UNSIGNED NOT NULL COMMENT '��� ������� ����������� (������ �� ������� �������������).',
	c_dt INTEGER NOT NULL COMMENT '����-����� ���������� �����������.',
	c_mark SMALLINT NULL COMMENT '������ �����. ����� ���� �� ������� (NULL).',
	PRIMARY KEY (c_uid),
	KEY (c_f_uid),
	KEY (c_u_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='����������� � ������ (������� ���������, �.�. ������ �������������� �����������).'
;


CREATE TABLE download_intensity
(
	di_uid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� ����������.',
	di_dl_uid BIGINT UNSIGNED NOT NULL COMMENT '������������� ������ �� ����������.',
	di_dt INTEGER NULL COMMENT '���� � ����� ���������� ���������� (unixtime).',
	PRIMARY KEY (di_uid),
	KEY (di_dl_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='������������ ���������� (���������� ��������� ����: ������� ��� �� ��������� ����� ������������ ���������� ������ ��� ����������).'
;


CREATE TABLE download_link
(
	dl_uid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� ������.',
	dl_f_uid BIGINT UNSIGNED NOT NULL COMMENT '������������� �����.',
	dl_hash CHAR(240) NOT NULL COMMENT '��� ��� ������������ ������ (6 sha1 �����, ��������� � ���� ������). �� ������ ��������� � dl_cookie_hash!!!',
	dl_dt INTEGER NOT NULL COMMENT '������ ������������� �� ... (unixtime)',
	dl_ipv4 CHAR(15) NULL COMMENT 'IPv4, ��� �������� ������������� ������. IPv4 � IPv6 �� ����� ������������ ���� NULL.',
	dl_ipv6 CHAR(39) NULL COMMENT 'IPv6, ��� �������� ������������� ������. IPv4 � IPv6 �� ����� ������������ ���� NULL.',
	dl_cookie_hash CHAR(240) NOT NULL COMMENT 'Cookie-hash ��� �������������� ������. 6 sha1. �� ������ ��������� � dl_hash!!!',
	dl_password CHAR(40) NULL COMMENT 'sha1-��� ������ �� ����������; NULL -- ���� ������ ���.',
	PRIMARY KEY (dl_uid),
	KEY (dl_f_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='������ �� ���������� ������.'
;


CREATE TABLE file
(
	f_uid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� �����.',
	f_fc_uid BIGINT UNSIGNED NULL COMMENT '������������� ��������� ������ (������ �� ������� ���������).',
	f_size BIGINT UNSIGNED NOT NULL COMMENT '������ ����� (� ������).',
	f_upload_datetime INTEGER NOT NULL COMMENT '����-����� �������� ����� �� ������.',
	f_save_datetime INTEGER NOT NULL COMMENT '����-�����, �� ������� ���� �������� �� �������.',
	f_src_name VARCHAR(255) NOT NULL COMMENT '�������� ��� ����� (��� �� ��������� � ������������ �� ����������). ��� ����������! ��� �������� �������� � f_src_ext!',
	f_src_ext VARCHAR(255) NULL COMMENT '�������� ���������� ����� (����� ��� ���� � ������������ �� ����������).',
	f_name CHAR(200) NOT NULL COMMENT '��� ����� �� �������. ���� sha1-�����.',
	f_sha1_checksum CHAR(40) NOT NULL COMMENT '����������� ����� �����, sha1-���.',
	f_ar_uid BIGINT UNSIGNED NOT NULL COMMENT '����� ������� � ����� (������ �� ������� ���� �������).',
	f_downloaded BIGINT UNSIGNED NULL DEFAULT 0 COMMENT '������� ���������� �����.',
	f_al_uid BIGINT UNSIGNED NULL COMMENT '���������� ����������� �� ������ � �����. ������ �� ������� ���������� �����������. ���� ���������� ����������� ������ � ��� �����, � ��� ���������, � ������� ����������� ����, ����������� ����� ������� ����������� (�.�. ������ ������������ �������, ��������: "� 16 ���" � "� 18 ���" -- ������ "� 18 ���").',
	f_del_link_hash CHAR(200) NOT NULL COMMENT '���� sha1-�����. ������ �� �������� �����, ���� ��� �������� �������������������� ������������. ������������������ ����� ������� ���� � ���� "������ ��������".',
	PRIMARY KEY (f_uid),
	UNIQUE UQ_file_f_uid(f_uid),
	KEY (f_ar_uid),
	KEY (f_fc_uid),
	KEY (f_al_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='����� �� �������. ���� �� ��������, �������� ����� ������������ ������. ����������� ��������� ����������� ������������������!'
;


CREATE TABLE file_category
(
	fc_uid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� ���������.',
	fc_name VARCHAR(255) NOT NULL COMMENT '�������� ���������.',
	fc_age_limit BIGINT UNSIGNED NULL COMMENT '���������� ����������� �� �������� ������ ������ ���������.',
	PRIMARY KEY (fc_uid),
	UNIQUE UQ_file_category_fc_name(fc_name),
	KEY (fc_age_limit),
	INDEX IDX_fc_age_limit_and_name (fc_age_limit ASC, fc_name ASC)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='��������� ������. ��������, "������", "�����", "���������" � �.�.'
;


CREATE TABLE file_m2m_user
(
	fmu_f_uid BIGINT UNSIGNED NOT NULL COMMENT '������������� �����.',
	fmu_u_uid BIGINT UNSIGNED NOT NULL COMMENT '������������� ������������.',
	fmu_direction ENUM('upload','download') NOT NULL COMMENT '������������ ������� ��� ������ ����.',
	fmu_count BIGINT UNSIGNED NULL COMMENT '������� ��� ������ ������������ �������� ������ �������� � ������ ������.',
	PRIMARY KEY (fmu_f_uid, fmu_u_uid, fmu_direction),
	KEY (fmu_f_uid),
	KEY (fmu_u_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='����� ����� ������������� � �������. ����� �����������, ������� �/��� ������ ������������ ��� ��� ���� ���� (� ������� ���). � �.�. �����������, ������� ��� ������������ ��������� ���� � ����� ������.'
;


CREATE TABLE file_m2m_user_group
(
	fmug_f_uid BIGINT UNSIGNED NOT NULL COMMENT '������������� �����.',
	fmug_ug_uid BIGINT UNSIGNED NOT NULL COMMENT '������������� ������.',
	fmug_rights BIGINT UNSIGNED NULL COMMENT '����� ������ ������������ �����.',
	PRIMARY KEY (fmug_f_uid, fmug_ug_uid),
	KEY (fmug_rights),
	KEY (fmug_f_uid),
	KEY (fmug_ug_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='����� �-� ����� ������� � �������� �������������. ����� ������ ������������� ������������ �����: �������, �������, ��������.'
;


CREATE TABLE ip_blacklist
(
	ib_ipv4 CHAR(15) NOT NULL COMMENT 'IPv4',
	ib_ipv6 CHAR(39) NOT NULL COMMENT 'IPv6',
	ib_dt INTEGER NOT NULL COMMENT '��� ������������ �� ... (unixtime).',
	ib_reason BIGINT UNSIGNED NULL COMMENT '�� ��� ������� (������ �� ������� ������ �����).',
	PRIMARY KEY (ib_ipv4, ib_ipv6),
	KEY (ib_reason)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='׸���� ������ ip-������� (��� ���� ������������������ ������������� ������������ ������� �������������).'
;


CREATE TABLE log
(
	l_uid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� ������ ����.',
	l_u_uid BIGINT UNSIGNED NULL COMMENT '������������� ������������ (NULL, ���� ��� ��������� ��������).',
	l_urr_uid INTEGER UNSIGNED NOT NULL COMMENT '������������� �������� (������ �� ������� ���� �����; ������ ����� ��������� ��� ���� ��������, �������� "��������� ����", "������� ����", "�������� ������������" � �.�.).',
	l_f_uid BIGINT UNSIGNED NULL COMMENT '������������� ����� (NULL, ���� �������� �� ������� � �������).',
	l_dt INTEGER NOT NULL COMMENT '����-����� (unixtime) ���������� ��������.',
	l_parameters TEXT NULL COMMENT '��������� ��������(��������������� ������).',
	PRIMARY KEY (l_uid),
	KEY (l_f_uid),
	KEY (l_u_uid),
	KEY (l_urr_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='��� (������ �������� �� ��������� �����, ����� ��� ����������� � ����� ����).'
;


CREATE TABLE log_archive
(
	la_uid BINARY(240) NOT NULL COMMENT '������������� ������ ���� (����� sha1 �����: �� ��������� PK, ������� � 4-� ��������� �����).',
	la_u_uid BIGINT UNSIGNED NULL COMMENT '������������� ������������ (NULL, ���� ��� ��������� ��������).',
	la_urr_uid INTEGER UNSIGNED NOT NULL COMMENT '������������� �������� (������ �� ������� ���� �����; ������ ����� ��������� ��� ���� ��������, �������� "��������� ����", "������� ����", "�������� ������������" � �.�.).',
	la_f_uid BIGINT UNSIGNED NULL COMMENT '������������� ����� (NULL, ���� �������� �� ������� � �������).',
	la_dt INTEGER NOT NULL COMMENT '����-����� (unixtime) ���������� ��������.',
	la_parameters TEXT NULL COMMENT '��������� ��������(��������������� ������).',
	PRIMARY KEY (la_uid),
	KEY (la_f_uid),
	KEY (la_u_uid),
	KEY (la_urr_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='����� ����.'
;


CREATE TABLE page
(
	p_uid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� ��������.',
	p_parent INTEGER UNSIGNED NULL COMMENT '������ �� ������������ �������� (rFK).',
	p_name VARCHAR(255) NOT NULL COMMENT '�������� �������� (������������ �� �������� � � �������).',
	p_menu_name VARCHAR(255) NOT NULL COMMENT '��� �������� ��� ����������� � ���� � ����� ����� (������, ��� ����������, ��� ��� �������� ��� ����������� �� ����� ��������).',
	p_hdr_title TEXT NOT NULL COMMENT 'TITLE',
	p_hdr_keywords TEXT NOT NULL COMMENT 'KEYWORDS',
	p_hdr_description TEXT NOT NULL COMMENT 'DESCRIPTION',
	p_text TEXT NULL COMMENT '��������� ���������� �������� (���� ����).',
	p_template VARCHAR(255) NOT NULL COMMENT '��� ����� �������� ������� ��������.',
	p_handler VARCHAR(255) NULL COMMENT '��� ����� ��������� ����������� ��������.',
	PRIMARY KEY (p_uid),
	KEY (p_parent)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='�������� �����.'
;


CREATE TABLE resource_info
(
	ri_uid INTEGER UNSIGNED NOT NULL COMMENT '������������� ������. � ���� ������� ������ ����� ������ ���� ������, �� ������������� �� ����� ������ ���� ��� ������������ ������ � �������� ������.',
	ri_registered_users BIGINT UNSIGNED NULL COMMENT '������� ������������� ���������������� �� �������.',
	ri_registered_users_today BIGINT UNSIGNED NULL COMMENT '������� ������������� ���������������� �� ������� �������.',
	ri_uploaded_files BIGINT UNSIGNED NULL COMMENT '������� ����� ��������� ������.',
	ri_uploaded_files_today BIGINT UNSIGNED NULL COMMENT '������� ������ ��������� �������.',
	ri_uploaded_files_size BIGINT UNSIGNED NULL COMMENT '����� ������ ����������� ������.',
	ri_uploaded_files_size_today BIGINT UNSIGNED NULL COMMENT '����� ������ ����������� ������� ������.',
	ri_downloaded_files BIGINT UNSIGNED NULL COMMENT '������� ����� ������� ������.',
	ri_downloaded_files_today BIGINT UNSIGNED NULL COMMENT '������� ������ ������� �������.',
	ri_downloaded_files_size BIGINT UNSIGNED NULL COMMENT '����� ���������� �� �� ����� (Mb).',
	ri_downloaded_files_size_today BIGINT UNSIGNED NULL COMMENT '����� ���������� �� ������� (Mb).',
	ri_update_dt INTEGER NULL,
	PRIMARY KEY (ri_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='���������� � ������� (��� ���� ����������).'
;


CREATE TABLE user
(
	u_uid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� ������������.',
	u_login VARCHAR(180) NOT NULL COMMENT '����� ������������. ����������!',
	u_password CHAR(40) NOT NULL COMMENT '������ ������������ (sha1-���).',
	u_email BINARY(255) NOT NULL COMMENT 'E-mail ������������.',
	u_name VARCHAR(255) NOT NULL COMMENT '��� ������������ ��� ����������� �� ��������� �������.',
	u_reg_date INTEGER NOT NULL COMMENT '����-����� ����������� ������������ (unixtime).',
	u_birth_date INTEGER NOT NULL COMMENT '���� �������� ������������ (� ��������� �� ���, unixtime). ���� ����������� � ����������, �.�. �� ��� ������ ������������ ����������� ���� ������� � ���������� � ������� ����������� �������������.',
	u_uploaded_files BIGINT UNSIGNED NULL COMMENT '������� ������� ������ (���������� �� �������).',
	u_downloaded_files BIGINT UNSIGNED NULL COMMENT '������� ������ ������ (���������� �� ����������).',
	u_comments BIGINT UNSIGNED NULL COMMENT '������� ������� ������������ (���������� �� ������������).',
	u_bonus_speed BIGINT UNSIGNED NULL COMMENT '����� �� �������� (Kb/sec).',
	u_bonus_upload BIGINT UNSIGNED NULL COMMENT '����� �� ���������� ������������� (���������� ������).',
	u_bonus_download BIGINT UNSIGNED NULL COMMENT '����� �� ���������� ������������ (���������� ������).',
	u_ban BIGINT UNSIGNED NULL COMMENT '��� (������ �� ������� ����; NULL - ���� �� �������).',
	u_ban_dt INTEGER NULL COMMENT '�� ����� ���� ������� (NULL - ���� �� �������).',
	PRIMARY KEY (u_uid),
	UNIQUE UQ_user_u_email(u_email),
	UNIQUE UQ_user_u_login(u_login),
	KEY (u_ban)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='������������������ ������������ �������������� �������.'
;


CREATE TABLE user_group
(
	ug_uid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� ������.',
	ug_name VARCHAR(255) NOT NULL COMMENT '�������� ������.',
	ug_description TEXT NULL COMMENT '�������� ������.',
	PRIMARY KEY (ug_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='������ ������������� (��� �������� "����� ������", ����� ������� � �����-�� ������ � �.�.) �������� ������ ���������� � user_group_m2m_user.'
;


CREATE TABLE user_group_m2m_user
(
	ugmu_ug_uid BIGINT UNSIGNED NOT NULL COMMENT '������������� ������.',
	ugmu_u_uid BIGINT UNSIGNED NOT NULL COMMENT '������������� ������������.',
	ugmu_is_owner BIT NOT NULL DEFAULT 0 COMMENT '�������� �� ������������ ���������� ������.',
	PRIMARY KEY (ugmu_ug_uid, ugmu_u_uid),
	KEY (ugmu_u_uid),
	KEY (ugmu_ug_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='����� ����� ������������� � �������������.'
;


CREATE TABLE user_role
(
	ur_uid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� ����.',
	ur_name VARCHAR(180) NULL COMMENT '�������� ���� (���������, ����� �� ���� ������������ � ��������).',
	ur_upload_volume_limit BIGINT UNSIGNED NULL COMMENT '����������� �� ������ ����������� ������ (� �����: 0:00:00-23:59:59).',
	ur_download_volume_limit BIGINT UNSIGNED NULL COMMENT '����������� �� ������ ����������� ������ (� �����: 0:00:00-23:59:59).',
	ur_upload_count_limit BIGINT UNSIGNED NULL COMMENT '����������� �� ���������� ����������� ������ (� �����: 0:00:00-23:59:59).',
	ur_download_count_limit BIGINT UNSIGNED NULL COMMENT '����������� �� ���������� ����������� ������ (� �����: 0:00:00-23:59:59).',
	ur_download_speed_limit BIGINT UNSIGNED NULL COMMENT '����������� �� �������� ���������� (�������� �������� ������ � ��� �� ������ �� ����������). Kb/sec.',
	PRIMARY KEY (ur_uid),
	UNIQUE UQ_user_role_ur_name(ur_name)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='���� ������������� (������������ ����� ���������� � ���������� ����� ������������, ��������: �������������, ����������������� ������������ � �.�.)'
;


CREATE TABLE user_role_m2m_user
(
	ur_uid INTEGER UNSIGNED NOT NULL COMMENT '������������� ����.',
	u_uid BIGINT UNSIGNED NULL COMMENT '������������� ������������.',
	PRIMARY KEY (ur_uid),
	KEY (u_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='����� �-� ����� ������ ������������� � ��������������.'
;


CREATE TABLE user_role_m2m_user_role_right
(
	urmurr_ur_uid INTEGER UNSIGNED NOT NULL COMMENT '������������� ����.',
	urmurr_urr_uid INTEGER UNSIGNED NULL COMMENT '������������� ����� ����.',
	PRIMARY KEY (urmurr_ur_uid),
	KEY (urmurr_urr_uid)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='����� �-� ����� ��������� ����� ������������� � ���� ����� �������������.'
;


CREATE TABLE user_role_right
(
	urr_uid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '������������� ����� ����.',
	urr_name VARCHAR(180) NULL COMMENT '�������� ����� ���� (���������, ����� �� ���� ������������ � ��������).',
	urr_description TEXT NULL COMMENT '�������� ����� ����.',
	PRIMARY KEY (urr_uid),
	UNIQUE UQ_user_role_right_urr_name(urr_name)
) DEFAULT CHARACTER SET utf8 DEFAULT CHARSET utf8 COLLATE utf8_general_ci ENGINE=InnoDB COMMENT='����� ����� (������� �������� ������ ����, �������� ������������� ����� ������ ������).'
;





--  Create Foreign Key Constraints 
ALTER TABLE access_right ADD CONSTRAINT FK_access_right_user 
	FOREIGN KEY (ar_u_uid) REFERENCES user (u_uid)
;

ALTER TABLE comment ADD CONSTRAINT FK_comment_file 
	FOREIGN KEY (c_f_uid) REFERENCES file (f_uid)
;

ALTER TABLE comment ADD CONSTRAINT FK_comment_user 
	FOREIGN KEY (c_u_uid) REFERENCES user (u_uid)
;

ALTER TABLE download_intensity ADD CONSTRAINT FK_download_intensity_download_link 
	FOREIGN KEY (di_dl_uid) REFERENCES download_link (dl_uid)
;

ALTER TABLE download_link ADD CONSTRAINT FK_download_link_file 
	FOREIGN KEY (dl_f_uid) REFERENCES file (f_uid)
;

ALTER TABLE file ADD CONSTRAINT FK_file_access_right 
	FOREIGN KEY (f_ar_uid) REFERENCES access_right (ar_uid)
;

ALTER TABLE file ADD CONSTRAINT FK_file_file_category 
	FOREIGN KEY (f_fc_uid) REFERENCES file_category (fc_uid)
;

ALTER TABLE file ADD CONSTRAINT FK_file_age_limit 
	FOREIGN KEY (f_al_uid) REFERENCES age_limit (al_id)
;

ALTER TABLE file_category ADD CONSTRAINT FK_file_category_age_limit 
	FOREIGN KEY (fc_age_limit) REFERENCES age_limit (al_id)
;

ALTER TABLE file_m2m_user ADD CONSTRAINT FK_file_m2o_user_file 
	FOREIGN KEY (fmu_f_uid) REFERENCES file (f_uid)
;

ALTER TABLE file_m2m_user ADD CONSTRAINT FK_file_m2o_user_user 
	FOREIGN KEY (fmu_u_uid) REFERENCES user (u_uid)
;

ALTER TABLE file_m2m_user_group ADD CONSTRAINT FK_file_m2m_user_group_access_right 
	FOREIGN KEY (fmug_rights) REFERENCES access_right (ar_uid)
;

ALTER TABLE file_m2m_user_group ADD CONSTRAINT FK_file_m2m_user_group_file 
	FOREIGN KEY (fmug_f_uid) REFERENCES file (f_uid)
;

ALTER TABLE file_m2m_user_group ADD CONSTRAINT FK_file_m2m_user_group_user_group 
	FOREIGN KEY (fmug_ug_uid) REFERENCES user_group (ug_uid)
;

ALTER TABLE ip_blacklist ADD CONSTRAINT FK_ip_blacklist_ban_reason 
	FOREIGN KEY (ib_reason) REFERENCES ban_reason (br_uid)
;

ALTER TABLE log ADD CONSTRAINT FK_log_file 
	FOREIGN KEY (l_f_uid) REFERENCES file (f_uid)
;

ALTER TABLE log ADD CONSTRAINT FK_log_user 
	FOREIGN KEY (l_u_uid) REFERENCES user (u_uid)
;

ALTER TABLE log ADD CONSTRAINT FK_log_user_role_right 
	FOREIGN KEY (l_urr_uid) REFERENCES user_role_right (urr_uid)
;

ALTER TABLE log_archive ADD CONSTRAINT FK_log_archive_file 
	FOREIGN KEY (la_f_uid) REFERENCES file (f_uid)
;

ALTER TABLE log_archive ADD CONSTRAINT FK_log_archive_user 
	FOREIGN KEY (la_u_uid) REFERENCES user (u_uid)
;

ALTER TABLE log_archive ADD CONSTRAINT FK_log_archive_user_role_right 
	FOREIGN KEY (la_urr_uid) REFERENCES user_role_right (urr_uid)
;

ALTER TABLE page ADD CONSTRAINT FK_page_page 
	FOREIGN KEY (p_parent) REFERENCES page (p_uid)
;

ALTER TABLE user ADD CONSTRAINT FK_user_ban_reason 
	FOREIGN KEY (u_ban) REFERENCES ban_reason (br_uid)
;

ALTER TABLE user_group_m2m_user ADD CONSTRAINT FK_user_group_m2m_user_user 
	FOREIGN KEY (ugmu_u_uid) REFERENCES user (u_uid)
;

ALTER TABLE user_group_m2m_user ADD CONSTRAINT FK_user_group_m2m_user_user_group 
	FOREIGN KEY (ugmu_ug_uid) REFERENCES user_group (ug_uid)
;

ALTER TABLE user_role_m2m_user ADD CONSTRAINT FK_user_role_m2m_user_user 
	FOREIGN KEY (u_uid) REFERENCES user (u_uid)
;

ALTER TABLE user_role_m2m_user ADD CONSTRAINT FK_user_role_m2m_user_user_role 
	FOREIGN KEY (ur_uid) REFERENCES user_role (ur_uid)
;

ALTER TABLE user_role_m2m_user_role_right ADD CONSTRAINT FK_user_role_m2m_user_role_right_user_role 
	FOREIGN KEY (urmurr_ur_uid) REFERENCES user_role (ur_uid)
;

ALTER TABLE user_role_m2m_user_role_right ADD CONSTRAINT FK_user_role_m2m_user_role_right_user_role_right 
	FOREIGN KEY (urmurr_urr_uid) REFERENCES user_role_right (urr_uid)
;






--  Create Triggers 
-- �� ��������� �������� 2+ ���������� ����� ������ ������������. �� ��������� ������������ �������� �����, ��� �������� ��������� � ������������������ �������.
DROP TRIGGER IF EXISTS `unique_access_right_bi`;

delimiter //

CREATE TRIGGER `unique_access_right_bi` BEFORE INSERT ON `access_right`
FOR EACH ROW
BEGIN
 DECLARE duplicates integer;

  SELECT count(*) INTO duplicates from `access_right` where `ar_name`=NEW.`ar_name` AND (ISNULL(`ar_u_uid`) OR `ar_u_uid`=NEW.`ar_u_uid`);

IF duplicates > 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Access right name must be unique for one user and must not be similar to predefined name', MYSQL_ERRNO = 1001;
    END IF;
 
END
//

delimiter ;

;
-- �� ��������� �������� 2+ ���������� ����� ������ ������������. �� ��������� ������������ �������� �����, ��� �������� ��������� � ������������������ �������.
DROP TRIGGER IF EXISTS `unique_access_right_bu`;

delimiter //

CREATE TRIGGER `unique_access_right_bu` BEFORE UPDATE ON `access_right`
FOR EACH ROW
BEGIN
 DECLARE duplicates integer;

  SELECT count(*) INTO duplicates from `access_right` where `ar_name`=NEW.`ar_name` AND (ISNULL(`ar_u_uid`) OR `ar_u_uid`=NEW.`ar_u_uid`);

IF duplicates > 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Access right name must be unique for one user and must not be similar to predefined name', MYSQL_ERRNO = 1001;
    END IF;
 
END
//

delimiter ;

;
DROP TRIGGER IF EXISTS `unique_hashes_bi`;

delimiter //

CREATE TRIGGER `unique_hashes_bi` BEFORE INSERT ON `file`
FOR EACH ROW
BEGIN
    IF NEW.`f_name` = NEW.`f_del_link_hash` THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Hashes for file name and deletion link can not be equal', MYSQL_ERRNO = 1001;
    END IF;
END
//

delimiter ;

;
DROP TRIGGER IF EXISTS `unique_hashes_bu`;

delimiter //


CREATE TRIGGER `unique_hashes_bu` BEFORE UPDATE ON `file`
FOR EACH ROW
BEGIN
    IF NEW.`f_name` = NEW.`f_del_link_hash` THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Hashes for file name and deletion link can not be equal', MYSQL_ERRNO = 1001;
    END IF;
END
//

delimiter ;

;
-- ��������� ����������� ������������� � ����� �������� &lt;= ���� �����������.
DROP TRIGGER IF EXISTS `reg_date_gt_birth_date_bi`;

delimiter //

CREATE TRIGGER `reg_date_gt_birth_date_bi` BEFORE INSERT ON `user`
FOR EACH ROW
BEGIN
    IF NEW.`u_reg_date` <= NEW.`u_birth_date` THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Registration date can not be less or equal to birth date', MYSQL_ERRNO = 1001;
    END IF;
END
//

delimiter ;

;
-- ��������� ����������, ������� ������� �� � ����, ��� ���� �������� ����� &lt;= ���� �����������.
DROP TRIGGER IF EXISTS `reg_date_gt_birth_date_bu`;

delimiter //

CREATE TRIGGER `reg_date_gt_birth_date_bu` BEFORE UPDATE ON `user`
FOR EACH ROW
BEGIN
    IF NEW.`u_reg_date` <= NEW.`u_birth_date` THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Registration date can not be less or equal to birth date', MYSQL_ERRNO = 1001;
    END IF;
END
//

delimiter ;

;
