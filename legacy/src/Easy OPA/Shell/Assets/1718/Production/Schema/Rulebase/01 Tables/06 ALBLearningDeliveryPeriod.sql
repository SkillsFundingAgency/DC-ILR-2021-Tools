IF OBJECT_ID('Rulebase.ALB_LearningDeliveryPeriod') IS NOT NULL
BEGIN
    DROP TABLE  Rulebase.[ALB_LearningDeliveryPeriod]
END;

  CREATE TABLE Rulebase.[ALB_LearningDeliveryPeriod]
  (
	LearnRefNumber							varchar(12),
	AimSeqNumber							int,
	
	ALBCode_ACM1                            int,    
	ALBSupportPayment_ACM1					decimal(15,5),
	AreaUpliftBalPayment_ACM1				decimal(15,5),
	AreaUpliftOnProgPayment_ACM1			decimal(15,5),	

	ALBCode_ACM2                            int,
	ALBSupportPayment_ACM2					decimal(15,5),
	AreaUpliftBalPayment_ACM2				decimal(15,5),
	AreaUpliftOnProgPayment_ACM2			decimal(15,5),	

	ALBCode_ACM3                          int,
	ALBSupportPayment_ACM3					decimal(15,5),
	AreaUpliftBalPayment_ACM3				decimal(15,5),
	AreaUpliftOnProgPayment_ACM3			decimal(15,5),	

	ALBCode_ACM4                            int,
	ALBSupportPayment_ACM4					decimal(15,5),
	AreaUpliftBalPayment_ACM4				decimal(15,5),
	AreaUpliftOnProgPayment_ACM4			decimal(15,5),	

	ALBCode_ACM5                            int,
	ALBSupportPayment_ACM5					decimal(15,5),
	AreaUpliftBalPayment_ACM5				decimal(15,5),
	AreaUpliftOnProgPayment_ACM5			decimal(15,5),	

	ALBCode_ACM6                            int,
	ALBSupportPayment_ACM6					decimal(15,5),
	AreaUpliftBalPayment_ACM6				decimal(15,5),
	AreaUpliftOnProgPayment_ACM6			decimal(15,5),	

	ALBCode_ACM7                            int,
	ALBSupportPayment_ACM7					decimal(15,5),
	AreaUpliftBalPayment_ACM7				decimal(15,5),
	AreaUpliftOnProgPayment_ACM7			decimal(15,5),	

	ALBCode_ACM8                            int,
	ALBSupportPayment_ACM8					decimal(15,5),
	AreaUpliftBalPayment_ACM8				decimal(15,5),
	AreaUpliftOnProgPayment_ACM8			decimal(15,5),	

	ALBCode_ACM9                            int,
	ALBSupportPayment_ACM9					decimal(15,5),
	AreaUpliftBalPayment_ACM9				decimal(15,5),
	AreaUpliftOnProgPayment_ACM9			decimal(15,5),	

	ALBCode_ACM10                            int,
	ALBSupportPayment_ACM10					decimal(15,5),
	AreaUpliftBalPayment_ACM10				decimal(15,5),
	AreaUpliftOnProgPayment_ACM10			decimal(15,5),	

	ALBCode_ACM11                            int,
	ALBSupportPayment_ACM11					decimal(15,5),
	AreaUpliftBalPayment_ACM11				decimal(15,5),
	AreaUpliftOnProgPayment_ACM11			decimal(15,5),	

	ALBCode_ACM12                            int,
	ALBSupportPayment_ACM12					decimal(15,5),
	AreaUpliftBalPayment_ACM12				decimal(15,5),
	AreaUpliftOnProgPayment_ACM12			decimal(15,5),	
	
	ALBCode_EFY                            int,	
	ALBSupportPayment_EFY					decimal(15,5),
	AreaUpliftBalPayment_EFY				decimal(15,5),
	AreaUpliftOnProgPayment_EFY				decimal(15,5),	
	
	CreatedOn								datetime DEFAULT GETDATE(),
)