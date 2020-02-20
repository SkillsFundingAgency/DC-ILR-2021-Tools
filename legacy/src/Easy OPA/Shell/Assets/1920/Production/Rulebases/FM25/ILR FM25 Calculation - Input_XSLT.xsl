<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs">
    <xsl:output method="xml"
                encoding="UTF-8"
                indent="yes"/>
    <xsl:template match="/">
        <session-data>
            <xsl:attribute name="xsi:noNamespaceSchemaLocation"
                           namespace="http://www.w3.org/2001/XMLSchema-instance">C:/PROGRA~2/Oracle/POLICY~1/bin/sessiondata.xsd</xsl:attribute>
            <entity>
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                </xsl:attribute>
                <xsl:attribute name="id">global</xsl:attribute>
                <xsl:attribute name="complete">
                    <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                </xsl:attribute>
                <xsl:for-each select="global">
                    <xsl:variable name="var_UKPRN"
                                  select="@UKPRN"/>
                    <xsl:variable name="var_LARSVersion"
                                  select="@LARSVersion"/>
                    <xsl:variable name="var_OrgVersion"
                                  select="@OrgVersion"/>
                    <xsl:variable name="var_PostcodeDisadvantageVersion"
                                  select="@PostcodeDisadvantageVersion"/>
                    <xsl:variable name="var_AreaCostFactor1618"
                                  select="@AreaCostFactor1618"/>
                    <xsl:variable name="var_DisadvantageProportion"
                                  select="@DisadvantageProportion"/>
                    <xsl:variable name="var_HistoricLargeProgrammeProportion"
                                  select="@HistoricLargeProgrammeProportion"/>
                    <xsl:variable name="var_ProgrammeWeighting"
                                  select="@ProgrammeWeighting"/>
                    <xsl:variable name="var_RetentionFactor"
                                  select="@RetentionFactor"/>
                    <xsl:variable name="var_SpecialistResources"
                                  select="@SpecialistResources"/>
                    <instance>
                        <xsl:attribute name="id">
                            <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_UKPRN)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">UKPRN</xsl:attribute>
                                <number-val>
                                    <xsl:value-of select="string($var_UKPRN)"/>
                                </number-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_LARSVersion)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">LARSVersion</xsl:attribute>
                                <text-val>
                                    <xsl:value-of select="string($var_LARSVersion)"/>
                                </text-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_OrgVersion)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">OrgVersion</xsl:attribute>
                                <text-val>
                                    <xsl:value-of select="string($var_OrgVersion)"/>
                                </text-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_PostcodeDisadvantageVersion)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">PostcodeDisadvantageVersion</xsl:attribute>
                                <text-val>
                                    <xsl:value-of select="string($var_PostcodeDisadvantageVersion)"/>
                                </text-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_AreaCostFactor1618)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">AreaCostFactor1618</xsl:attribute>
                                <number-val>
                                    <xsl:value-of select="string($var_AreaCostFactor1618)"/>
                                </number-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_DisadvantageProportion)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">DisadvantageProportion</xsl:attribute>
                                <number-val>
                                    <xsl:value-of select="string($var_DisadvantageProportion)"/>
                                </number-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_HistoricLargeProgrammeProportion)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">HistoricLargeProgrammeProportion</xsl:attribute>
                                <number-val>
                                    <xsl:value-of select="string($var_HistoricLargeProgrammeProportion)"/>
                                </number-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_ProgrammeWeighting)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">ProgrammeWeighting</xsl:attribute>
                                <number-val>
                                    <xsl:value-of select="string($var_ProgrammeWeighting)"/>
                                </number-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_RetentionFactor)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">RetentionFactor</xsl:attribute>
                                <number-val>
                                    <xsl:value-of select="string($var_RetentionFactor)"/>
                                </number-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_SpecialistResources)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">SpecialistResources</xsl:attribute>
                                <boolean-val>
                                    <xsl:value-of select="string($var_SpecialistResources)"/>
                                </boolean-val>
                            </attribute>
                        </xsl:if>
                        <entity>
                            <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                            </xsl:attribute>
                            <xsl:attribute name="id">Learner</xsl:attribute>
                            <xsl:attribute name="complete">
                                <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                            </xsl:attribute>
                            <xsl:for-each select="Learner">
                                <xsl:variable name="var_LearnRefNumber"
                                              select="@LearnRefNumber"/>
                                <xsl:variable name="var_ULN"
                                              select="@ULN"/>
                                <xsl:variable name="var_DateOfBirth"
                                              select="@DateOfBirth"/>
                                <xsl:variable name="var_EngGrade"
                                              select="@EngGrade"/>
                                <xsl:variable name="var_MathGrade"
                                              select="@MathGrade"/>
                                <xsl:variable name="var_LrnFAM_ECF"
                                              select="@LrnFAM_ECF"/>
                                <xsl:variable name="var_LrnFAM_EDF1"
                                              select="@LrnFAM_EDF1"/>
                                <xsl:variable name="var_LrnFAM_EDF2"
                                              select="@LrnFAM_EDF2"/>
                                <xsl:variable name="var_LrnFAM_EHC"
                                              select="@LrnFAM_EHC"/>
                                <xsl:variable name="var_LrnFAM_HNS"
                                              select="@LrnFAM_HNS"/>
                                <xsl:variable name="var_LrnFAM_MCF"
                                              select="@LrnFAM_MCF"/>
                                <xsl:variable name="var_PlanEEPHours"
                                              select="@PlanEEPHours"/>
                                <xsl:variable name="var_PlanLearnHours"
                                              select="@PlanLearnHours"/>
                                <xsl:variable name="var_PostcodeDisadvantageUplift"
                                              select="@PostcodeDisadvantageUplift"/>
                                <instance>
                                    <xsl:attribute name="id">
                                        <xsl:value-of select="generate-id(.)"/>
                                    </xsl:attribute>
                                    <xsl:if test="string(boolean($var_LearnRefNumber)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LearnRefNumber</xsl:attribute>
                                            <text-val>
                                                <xsl:value-of select="string($var_LearnRefNumber)"/>
                                            </text-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_ULN)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">ULN</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_ULN)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_DateOfBirth)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">DateOfBirth</xsl:attribute>
                                            <date-val>
                                                <xsl:value-of select="string($var_DateOfBirth)"/>
                                            </date-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_EngGrade)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">EngGrade</xsl:attribute>
                                            <text-val>
                                                <xsl:value-of select="string($var_EngGrade)"/>
                                            </text-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_MathGrade)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">MathGrade</xsl:attribute>
                                            <text-val>
                                                <xsl:value-of select="string($var_MathGrade)"/>
                                            </text-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_LrnFAM_ECF)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LrnFAM_ECF</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_LrnFAM_ECF)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_LrnFAM_EDF1)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LrnFAM_EDF1</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_LrnFAM_EDF1)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_LrnFAM_EDF2)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LrnFAM_EDF2</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_LrnFAM_EDF2)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_LrnFAM_EHC)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LrnFAM_EHC</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_LrnFAM_EHC)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_LrnFAM_HNS)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LrnFAM_HNS</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_LrnFAM_HNS)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_LrnFAM_MCF)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LrnFAM_MCF</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_LrnFAM_MCF)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_PlanEEPHours)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">PlanEEPHours</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_PlanEEPHours)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_PlanLearnHours)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">PlanLearnHours</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_PlanLearnHours)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_PostcodeDisadvantageUplift)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">PostcodeDisadvantageUplift</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_PostcodeDisadvantageUplift)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <entity>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="generate-id(.)"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="id">DPOutcome</xsl:attribute>
                                        <xsl:attribute name="complete">
                                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                        </xsl:attribute>
                                        <xsl:for-each select="DPOutcome">
                                            <xsl:variable name="var_OutCode"
                                                          select="@OutCode"/>
                                            <xsl:variable name="var_OutType"
                                                          select="@OutType"/>
                                            <instance>
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="generate-id(.)"/>
                                                </xsl:attribute>
                                                <xsl:if test="string(boolean($var_OutCode)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">OutCode</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_OutCode)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_OutType)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">OutType</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_OutType)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                            </instance>
                                        </xsl:for-each>
                                    </entity>
                                    <entity>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="generate-id(.)"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="id">Camps_Identifiers_Reference_DataFunding</xsl:attribute>
                                        <xsl:attribute name="complete">
                                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                        </xsl:attribute>
                                        <xsl:for-each select="Camps_Identifiers_Reference_DataFunding">
                                            <xsl:variable name="var_EffectiveFrom"
                                                          select="@EffectiveFrom"/>
                                            <xsl:variable name="var_EffectiveTo"
                                                          select="@EffectiveTo"/>
                                            <xsl:variable name="var_CampusFundingSpecialistResources"
                                                          select="@CampusFundingSpecialistResources"/>
                                            <instance>
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="generate-id(.)"/>
                                                </xsl:attribute>
                                                <xsl:if test="string(boolean($var_EffectiveFrom)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EffectiveFrom</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_EffectiveFrom)"/>
                                                        </date-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EffectiveTo)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EffectiveTo</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_EffectiveTo)"/>
                                                        </date-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_CampusFundingSpecialistResources)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">CampusFundingSpecialistResources</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_CampusFundingSpecialistResources)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                            </instance>
                                        </xsl:for-each>
                                    </entity>
                                    <entity>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="generate-id(.)"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="id">LearningDelivery</xsl:attribute>
                                        <xsl:attribute name="complete">
                                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                        </xsl:attribute>
                                        <xsl:for-each select="LearningDelivery">
                                            <xsl:variable name="var_LearnAimRef"
                                                          select="@LearnAimRef"/>
                                            <xsl:variable name="var_AimType"
                                                          select="@AimType"/>
                                            <xsl:variable name="var_AimSeqNumber"
                                                          select="@AimSeqNumber"/>
                                            <xsl:variable name="var_FundModel"
                                                          select="@FundModel"/>
                                            <xsl:variable name="var_ProgType"
                                                          select="@ProgType"/>
                                            <xsl:variable name="var_LearnStartDate"
                                                          select="@LearnStartDate"/>
                                            <xsl:variable name="var_LearnPlanEndDate"
                                                          select="@LearnPlanEndDate"/>
                                            <xsl:variable name="var_LearnActEndDate"
                                                          select="@LearnActEndDate"/>
                                            <xsl:variable name="var_CompStatus"
                                                          select="@CompStatus"/>
                                            <xsl:variable name="var_WithdrawReason"
                                                          select="@WithdrawReason"/>
                                            <xsl:variable name="var_LearnAimRefTitle"
                                                          select="@LearnAimRefTitle"/>
                                            <xsl:variable name="var_LearnAimRefType"
                                                          select="@LearnAimRefType"/>
                                            <xsl:variable name="var_AwardOrgCode"
                                                          select="@AwardOrgCode"/>
                                            <xsl:variable name="var_EFACOFType"
                                                          select="@EFACOFType"/>
                                            <xsl:variable name="var_SectorSubjectAreaTier2"
                                                          select="@SectorSubjectAreaTier2"/>
                                            <instance>
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="generate-id(.)"/>
                                                </xsl:attribute>
                                                <xsl:if test="string(boolean($var_LearnAimRef)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LearnAimRef</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_LearnAimRef)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_AimType)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">AimType</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_AimType)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_AimSeqNumber)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">AimSeqNumber</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_AimSeqNumber)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_FundModel)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">FundModel</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_FundModel)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_ProgType)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">ProgType</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_ProgType)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LearnStartDate)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LearnStartDate</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_LearnStartDate)"/>
                                                        </date-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LearnPlanEndDate)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LearnPlanEndDate</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_LearnPlanEndDate)"/>
                                                        </date-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LearnActEndDate)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LearnActEndDate</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_LearnActEndDate)"/>
                                                        </date-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_CompStatus)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">CompStatus</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_CompStatus)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_WithdrawReason)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">WithdrawReason</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_WithdrawReason)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LearnAimRefTitle)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LearnAimRefTitle</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_LearnAimRefTitle)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LearnAimRefType)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LearnAimRefType</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_LearnAimRefType)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_AwardOrgCode)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">AwardOrgCode</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_AwardOrgCode)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EFACOFType)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EFACOFType</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_EFACOFType)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_SectorSubjectAreaTier2)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">SectorSubjectAreaTier2</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_SectorSubjectAreaTier2)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <entity>
                                                    <xsl:attribute name="id">
                                                        <xsl:value-of select="generate-id(.)"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="id">LearningDeliveryFAM</xsl:attribute>
                                                    <xsl:attribute name="complete">
                                                        <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                    </xsl:attribute>
                                                    <xsl:for-each select="LearningDeliveryFAM">
                                                        <xsl:variable name="var_LearnDelFAMCode"
                                                                      select="@LearnDelFAMCode"/>
                                                        <xsl:variable name="var_LearnDelFAMType"
                                                                      select="@LearnDelFAMType"/>
                                                        <xsl:variable name="var_LearnDelFAMDateFrom"
                                                                      select="@LearnDelFAMDateFrom"/>
                                                        <xsl:variable name="var_LearnDelFAMDateTo"
                                                                      select="@LearnDelFAMDateTo"/>
                                                        <instance>
                                                            <xsl:attribute name="id">
                                                                <xsl:value-of select="generate-id(.)"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string(boolean($var_LearnDelFAMCode)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LearnDelFAMCode</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_LearnDelFAMCode)"/>
                                                                    </text-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_LearnDelFAMType)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LearnDelFAMType</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_LearnDelFAMType)"/>
                                                                    </text-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_LearnDelFAMDateFrom)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LearnDelFAMDateFrom</xsl:attribute>
                                                                    <date-val>
                                                                        <xsl:value-of select="string($var_LearnDelFAMDateFrom)"/>
                                                                    </date-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_LearnDelFAMDateTo)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LearnDelFAMDateTo</xsl:attribute>
                                                                    <date-val>
                                                                        <xsl:value-of select="string($var_LearnDelFAMDateTo)"/>
                                                                    </date-val>
                                                                </attribute>
                                                            </xsl:if>
                                                        </instance>
                                                    </xsl:for-each>
                                                </entity>
                                                <entity>
                                                    <xsl:attribute name="id">
                                                        <xsl:value-of select="generate-id(.)"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="id">LearningDeliveryLARSValidity</xsl:attribute>
                                                    <xsl:attribute name="complete">
                                                        <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                    </xsl:attribute>
                                                    <xsl:for-each select="LearningDeliveryLARSValidity">
                                                        <xsl:variable name="var_ValidityCategory"
                                                                      select="@ValidityCategory"/>
                                                        <xsl:variable name="var_ValidityLastNewStartDate"
                                                                      select="@ValidityLastNewStartDate"/>
                                                        <xsl:variable name="var_ValidityStartDate"
                                                                      select="@ValidityStartDate"/>
                                                        <instance>
                                                            <xsl:attribute name="id">
                                                                <xsl:value-of select="generate-id(.)"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string(boolean($var_ValidityCategory)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">ValidityCategory</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_ValidityCategory)"/>
                                                                    </text-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_ValidityLastNewStartDate)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">ValidityLastNewStartDate</xsl:attribute>
                                                                    <date-val>
                                                                        <xsl:value-of select="string($var_ValidityLastNewStartDate)"/>
                                                                    </date-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_ValidityStartDate)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">ValidityStartDate</xsl:attribute>
                                                                    <date-val>
                                                                        <xsl:value-of select="string($var_ValidityStartDate)"/>
                                                                    </date-val>
                                                                </attribute>
                                                            </xsl:if>
                                                        </instance>
                                                    </xsl:for-each>
                                                </entity>
                                            </instance>
                                        </xsl:for-each>
                                    </entity>
                                </instance>
                            </xsl:for-each>
                        </entity>
                    </instance>
                </xsl:for-each>
            </entity>
        </session-data>
    </xsl:template>
</xsl:stylesheet>
