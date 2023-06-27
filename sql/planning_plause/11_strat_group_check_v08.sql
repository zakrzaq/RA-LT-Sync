select distinct
   a.matnr as "Matnr"
  ,a.werks as "Werks"
  ,a.strgr as "Strgr"
  ,a.miskz as "MISKZ"
  ,a.sbdkz as "SBDKZ"
  ,b.mtart as mat_type
  ,a.dispo as MRP_Cont
  ,z.dsnam as planner
  ,a.mmsta as plant_block

  , 'Strat group 70 or ZB must have mixed mrp=1 and ind/col=2, if ZCNV strat should be 40' as "error type"

from sapecc_dly_librarian.marc a
		,sapecc_dly_librarian.mara b
		,sapecc_librarian.t024d z
    
where 
-- join  
	    a.mandt = '400'
  and a.mandt = b.mandt
  and a.mandt = z.mandt
  and a.matnr = b.matnr  
  and a.werks = z.werks
  and a.dispo = z.dispo	
-- filter
  and a.werks not in ('1010', '1030', '1110', '1060')
  and a.werks not between '3500' and '3900'
  and a.lvorm = ' '
  and b.lvorm = ' '
  and a.strgr in ('70', 'ZB')
  and a.mmsta not in ('07','08','09','01','NA','FC','ZP','Z8','ZG','ZQ','ZJ','ZL')
  and a.matnr not like 'COPY%'
  and b.mtart <> 'ZCFG'
--error
  and a.miskz || a.sbdkz != ('12')
  
union

select  
   a.matnr as "Matnr"
  ,a.werks as "Werks"
  ,a.strgr as "Strgr"
  ,a.miskz as "MISKZ"
  ,a.sbdkz as "SBDKZ"
  ,b.mtart as mat_type
  ,a.dispo as MRP_Cont
  ,z.dsnam as planner
  ,a.mmsta as plant_block
  , 'Strat group 74 or ZC must have mixed mrp=3 and ind/col=1 or 2, if ZCNV strat should be 40' as "error type"

from  sapecc_dly_librarian.marc a
		, sapecc_librarian.mara b
		, sapecc_librarian.t024d z
		
where 
--join
	    a.mandt = '400'
  and a.mandt = b.mandt
  and a.mandt = z.mandt
  and a.matnr = b.matnr  
  and a.werks = z.werks
  and a.dispo = z.dispo	
-- filter
  and a.werks not in ('1010', '1030', '1110', '1060')
  and a.werks not between '3500' and '3900'
  and a.lvorm = ' '
  and b.lvorm = ' '
  and a.strgr in ('74', 'ZC')
  and a.mmsta not in ('07','99','08','09','01','NA','FC','ZP','Z8','ZG','ZQ','ZJ','ZL')
  and a.matnr not like 'COPY%'
  and b.mtart <> 'ZCFG'
-- error
  and a.miskz || a.sbdkz not in ('32','31')
