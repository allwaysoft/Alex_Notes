
****************************************************************************************************
****************************************************************************************************
Test Case:

exec dbms_workload_repository.create_snapshot;

create table tmptab as select * from all_objects;

begin
	for i in 1..20 loop
		insert into tmptab select * from all_objects;
		delete from tmptab;
	end loop;
	commit;
end;
/

exec dbms_workload_repository.create_snapshot;

********************************************************************************************************************************************************************************************************
1 Running ADDM in DB Model

To run ADDM in DB model, use the DBMS_ADDM.ANALYZE_DB procedure:

select snap_id,begin_interval_time from dba_hist_snapshot order by begin_interval_time desc;

BEGIN
DBMS_ADDM.ANALYZE_DB (
   task_name           IN OUT VARCHAR2,
   begin_snapshot      IN     NUMBER,
   end_snapshot        IN     NUMBER,
   db_id               IN     NUMBER := NULL);
END;
/
creates an ADDM task in database analysis mode

VAR tname VARCHAR2(30);
BEGIN
  :tname := 'ADDM for test';
  DBMS_ADDM.ANALYZE_DB(:tname, 82, 84);
END;
/
********************************************************************************************************************************************************************************************************

Running ADDM in Instance Mode

BEGIN
DBMS_ADDM.ANALYZE_INST (
   task_name           IN OUT VARCHAR2,
   begin_snapshot      IN     NUMBER,
   end_snapshot        IN     NUMBER,
   instance_number     IN     NUMBER := NULL,
   db_id               IN     NUMBER := NULL);
END;
/
VAR tname VARCHAR2(30);
BEGIN
  :tname := 'my ADDM for 7PM to 9PM';
  DBMS_ADDM.ANALYZE_INST(:tname, 137, 145, 1);
END;
/

********************************************************************************************************************************************************************************************************

Running ADDM in Partial Mode

BEGIN
DBMS_ADDM.ANALYZE_PARTIAL (
   task_name           IN OUT VARCHAR2,
   instance_numbers    IN     VARCHAR2,
   begin_snapshot      IN     NUMBER,
   end_snapshot        IN     NUMBER,
   db_id               IN     NUMBER := NULL);
END;
/
VAR tname VARCHAR2(30);
BEGIN
  :tname := 'my ADDM for 7PM to 9PM';
  DBMS_ADDM.ANALYZE_PARTIAL(:tname, '1,2,4', 137, 145);
END;
/

********************************************************************************************************************************************************************************************************

Display ADDM Report

DBMS_ADDM.GET_REPORT (
   task_name           IN VARCHAR2
  RETURN CLOB);

SET LONG 1000000 PAGESIZE 0;
SELECT DBMS_ADDM.GET_REPORT(:tname) FROM DUAL;

****************************************************************************************************
****************************************************************************************************

Views related to ADDM information

DBA_ADVISOR_FINDINGS

DBA_ADDM_FINDINGS

DBA_ADVISOR_FINDING_NAMES

DBA_ADVISOR_RECOMMENDATIONS

DBA_ADVISOR_TASKS

************************************************************************************************************************************************************************************************************************************************************************************************************

****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
