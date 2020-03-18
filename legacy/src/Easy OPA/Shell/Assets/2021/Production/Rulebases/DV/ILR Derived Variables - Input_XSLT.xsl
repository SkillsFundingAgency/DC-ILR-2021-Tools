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
                    <xsl:variable name="var_ThirdSector"
                                  select="@ThirdSector"/>
                    <xsl:variable name="var_UKPRN"
                                  select="@UKPRN"/>
                    <instance>
                        <xsl:attribute name="id">
                            <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_ThirdSector)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">ThirdSector</xsl:attribute>
                                <number-val>
                                    <xsl:value-of select="string($var_ThirdSector)"/>
                                </number-val>
                            </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_UKPRN)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">UKPRN</xsl:attribute>
                                <number-val>
                                    <xsl:value-of select="string($var_UKPRN)"/>
                                </number-val>
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
                                <xsl:variable name="var_DateOfBirth"
                                              select="@DateOfBirth"/>
                                <xsl:variable name="var_EFA_CalcFundingLineType"
                                              select="@EFA_CalcFundingLineType"/>
                                <xsl:variable name="var_EFA_CalcStartFunding"
                                              select="@EFA_CalcStartFunding"/>
                                <xsl:variable name="var_EFA_CalcThresholdDays"
                                              select="@EFA_CalcThresholdDays"/>
                                <xsl:variable name="var_Ethnicity"
                                              select="@Ethnicity"/>
                                <xsl:variable name="var_LearnRefNumber"
                                              select="@LearnRefNumber"/>
                                <xsl:variable name="var_LLDDHealthProb"
                                              select="@LLDDHealthProb"/>
                                <xsl:variable name="var_PlanEEPHours"
                                              select="@PlanEEPHours"/>
                                <xsl:variable name="var_PlanLearnHours"
                                              select="@PlanLearnHours"/>
                                <xsl:variable name="var_PrevLearnRefNumber"
                                              select="@PrevLearnRefNumber"/>
                                <xsl:variable name="var_PrevUKPRN"
                                              select="@PrevUKPRN"/>
                                <xsl:variable name="var_PriorAttain"
                                              select="@PriorAttain"/>
                                <xsl:variable name="var_ULN"
                                              select="@ULN"/>
                                <instance>
                                    <xsl:attribute name="id">
                                        <xsl:value-of select="generate-id(.)"/>
                                    </xsl:attribute>
                                    <xsl:if test="string(boolean($var_DateOfBirth)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">DateOfBirth</xsl:attribute>
                                            <date-val>
                                                <xsl:value-of select="string($var_DateOfBirth)"/>
                                            </date-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_EFA_CalcFundingLineType)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">EFA_CalcFundingLineType</xsl:attribute>
                                            <text-val>
                                                <xsl:value-of select="string($var_EFA_CalcFundingLineType)"/>
                                            </text-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_EFA_CalcStartFunding)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">EFA_CalcStartFunding</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_EFA_CalcStartFunding)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_EFA_CalcThresholdDays)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">EFA_CalcThresholdDays</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_EFA_CalcThresholdDays)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_Ethnicity)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">Ethnicity</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_Ethnicity)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_LearnRefNumber)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LearnRefNumber</xsl:attribute>
                                            <text-val>
                                                <xsl:value-of select="string($var_LearnRefNumber)"/>
                                            </text-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_LLDDHealthProb)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">LLDDHealthProb</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_LLDDHealthProb)"/>
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
                                    <xsl:if test="string(boolean($var_PrevLearnRefNumber)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">PrevLearnRefNumber</xsl:attribute>
                                            <text-val>
                                                <xsl:value-of select="string($var_PrevLearnRefNumber)"/>
                                            </text-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_PrevUKPRN)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">PrevUKPRN</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_PrevUKPRN)"/>
                                            </number-val>
                                        </attribute>
                                    </xsl:if>
                                    <xsl:if test="string(boolean($var_PriorAttain)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">PriorAttain</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_PriorAttain)"/>
                                            </number-val>
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
                                    <entity>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="generate-id(.)"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="id">LearnerEmploymentStatus</xsl:attribute>
                                        <xsl:attribute name="complete">
                                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                        </xsl:attribute>
                                        <xsl:for-each select="LearnerEmploymentStatus">
                                            <xsl:variable name="var_DateEmpStatApp"
                                                          select="@DateEmpStatApp"/>
                                            <xsl:variable name="var_EmpId"
                                                          select="@EmpId"/>
                                            <xsl:variable name="var_EmpStat"
                                                          select="@EmpStat"/>
                                            <xsl:variable name="var_EmpStatMon_BSI"
                                                          select="@EmpStatMon_BSI"/>
                                            <xsl:variable name="var_EmpStatMon_EII"
                                                          select="@EmpStatMon_EII"/>
                                            <xsl:variable name="var_EmpStatMon_LOE"
                                                          select="@EmpStatMon_LOE"/>
                                            <xsl:variable name="var_EmpStatMon_LOU"
                                                          select="@EmpStatMon_LOU"/>
                                            <xsl:variable name="var_EmpStatMon_PEI"
                                                          select="@EmpStatMon_PEI"/>
                                            <xsl:variable name="var_EmpStatMon_SEI"
                                                          select="@EmpStatMon_SEI"/>
                                            <xsl:variable name="var_EmpStatMon_SEM"
                                                          select="@EmpStatMon_SEM"/>
                                            <instance>
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="generate-id(.)"/>
                                                </xsl:attribute>
                                                <xsl:if test="string(boolean($var_DateEmpStatApp)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">DateEmpStatApp</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_DateEmpStatApp)"/>
                                                        </date-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EmpId)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EmpId</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_EmpId)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EmpStat)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EmpStat</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_EmpStat)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EmpStatMon_BSI)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EmpStatMon_BSI</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_EmpStatMon_BSI)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EmpStatMon_EII)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EmpStatMon_EII</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_EmpStatMon_EII)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EmpStatMon_LOE)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EmpStatMon_LOE</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_EmpStatMon_LOE)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EmpStatMon_LOU)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EmpStatMon_LOU</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_EmpStatMon_LOU)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EmpStatMon_PEI)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EmpStatMon_PEI</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_EmpStatMon_PEI)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EmpStatMon_SEI)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EmpStatMon_SEI</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_EmpStatMon_SEI)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EmpStatMon_SEM)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EmpStatMon_SEM</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_EmpStatMon_SEM)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                            </instance>
                                        </xsl:for-each>
                                    </entity>
                                    <entity>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="generate-id(.)"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="id">ContactPreference</xsl:attribute>
                                        <xsl:attribute name="complete">
                                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                        </xsl:attribute>
                                        <xsl:for-each select="ContactPreference">
                                            <xsl:variable name="var_ContPrefCode"
                                                          select="@ContPrefCode"/>
                                            <xsl:variable name="var_ContPrefType"
                                                          select="@ContPrefType"/>
                                            <instance>
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="generate-id(.)"/>
                                                </xsl:attribute>
                                                <xsl:if test="string(boolean($var_ContPrefCode)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">ContPrefCode</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_ContPrefCode)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_ContPrefType)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">ContPrefType</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_ContPrefType)"/>
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
                                            <xsl:variable name="var_AimSeqNumber"
                                                          select="@AimSeqNumber"/>
                                            <xsl:variable name="var_AimType"
                                                          select="@AimType"/>
                                            <xsl:variable name="var_ALB_CalcFundingLineType"
                                                          select="@ALB_CalcFundingLineType"/>
                                            <xsl:variable name="var_ALB_CalcStartFunding"
                                                          select="@ALB_CalcStartFunding"/>
                                            <xsl:variable name="var_CompStatus"
                                                          select="@CompStatus"/>
                                            <xsl:variable name="var_CreditBasedFwkType"
                                                          select="@CreditBasedFwkType"/>
                                            <xsl:variable name="var_EnglandFEHEStatus"
                                                          select="@EnglandFEHEStatus"/>
                                            <xsl:variable name="var_FrameworkComponentType"
                                                          select="@FrameworkComponentType"/>
                                            <xsl:variable name="var_FundModel"
                                                          select="@FundModel"/>
                                            <xsl:variable name="var_FworkCode"
                                                          select="@FworkCode"/>
                                            <xsl:variable name="var_LearnActEndDate"
                                                          select="@LearnActEndDate"/>
                                            <xsl:variable name="var_LearnAimRef"
                                                          select="@LearnAimRef"/>
                                            <xsl:variable name="var_LearnAimRefType"
                                                          select="@LearnAimRefType"/>
                                            <xsl:variable name="var_LearnPlanEndDate"
                                                          select="@LearnPlanEndDate"/>
                                            <xsl:variable name="var_LearnStartDate"
                                                          select="@LearnStartDate"/>
                                            <xsl:variable name="var_LrnDelFAM_ADL"
                                                          select="@LrnDelFAM_ADL"/>
                                            <xsl:variable name="var_LrnDelFAM_EEF"
                                                          select="@LrnDelFAM_EEF"/>
                                            <xsl:variable name="var_LrnDelFAM_FFI"
                                                          select="@LrnDelFAM_FFI"/>
                                            <xsl:variable name="var_LrnDelFAM_LDM1"
                                                          select="@LrnDelFAM_LDM1"/>
                                            <xsl:variable name="var_LrnDelFAM_LDM2"
                                                          select="@LrnDelFAM_LDM2"/>
                                            <xsl:variable name="var_LrnDelFAM_LDM3"
                                                          select="@LrnDelFAM_LDM3"/>
                                            <xsl:variable name="var_LrnDelFAM_LDM4"
                                                          select="@LrnDelFAM_LDM4"/>
                                            <xsl:variable name="var_LrnDelFAM_RES"
                                                          select="@LrnDelFAM_RES"/>
                                            <xsl:variable name="var_LrnDelFAM_SOF"
                                                          select="@LrnDelFAM_SOF"/>
                                            <xsl:variable name="var_LrnDelFAM_SPP"
                                                          select="@LrnDelFAM_SPP"/>
                                            <xsl:variable name="var_NotionalNVQLevel"
                                                          select="@NotionalNVQLevel"/>
                                            <xsl:variable name="var_NotionalNVQLevelv2"
                                                          select="@NotionalNVQLevelv2"/>
                                            <xsl:variable name="var_OrigLearnStartDate"
                                                          select="@OrigLearnStartDate"/>
                                            <xsl:variable name="var_Outcome"
                                                          select="@Outcome"/>
                                            <xsl:variable name="var_OutGrade"
                                                          select="@OutGrade"/>
                                            <xsl:variable name="var_ProgType"
                                                          select="@ProgType"/>
                                            <xsl:variable name="var_PwayCode"
                                                          select="@PwayCode"/>
                                            <xsl:variable name="var_RegulatedCreditValue"
                                                          select="@RegulatedCreditValue"/>
                                            <xsl:variable name="var_Section96Valid16to18"
                                                          select="@Section96Valid16to18"/>
                                            <xsl:variable name="var_SectorSubjectAreaTier1"
                                                          select="@SectorSubjectAreaTier1"/>
                                            <xsl:variable name="var_SectorSubjectAreaTier2"
                                                          select="@SectorSubjectAreaTier2"/>
                                            <xsl:variable name="var_SFA_CalcFundingLineType"
                                                          select="@SFA_CalcFundingLineType"/>
                                            <xsl:variable name="var_SFA_CalcLargeEmpFactor"
                                                          select="@SFA_CalcLargeEmpFactor"/>
                                            <xsl:variable name="var_SFA_CalcStartFunding"
                                                          select="@SFA_CalcStartFunding"/>
                                            <xsl:variable name="var_SFA_CalcThresholdDays"
                                                          select="@SFA_CalcThresholdDays"/>
                                            <xsl:variable name="var_WithdrawReason"
                                                          select="@WithdrawReason"/>
                                            <instance>
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="generate-id(.)"/>
                                                </xsl:attribute>
                                                <xsl:if test="string(boolean($var_AimSeqNumber)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">AimSeqNumber</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_AimSeqNumber)"/>
                                                        </number-val>
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
                                                <xsl:if test="string(boolean($var_ALB_CalcFundingLineType)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">ALB_CalcFundingLineType</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_ALB_CalcFundingLineType)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_ALB_CalcStartFunding)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">ALB_CalcStartFunding</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_ALB_CalcStartFunding)"/>
                                                        </number-val>
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
                                                <xsl:if test="string(boolean($var_CreditBasedFwkType)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">CreditBasedFwkType</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_CreditBasedFwkType)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EnglandFEHEStatus)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EnglandFEHEStatus</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_EnglandFEHEStatus)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_FrameworkComponentType)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">FrameworkComponentType</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_FrameworkComponentType)"/>
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
                                                <xsl:if test="string(boolean($var_FworkCode)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">FworkCode</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_FworkCode)"/>
                                                        </number-val>
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
                                                <xsl:if test="string(boolean($var_LearnAimRef)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LearnAimRef</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_LearnAimRef)"/>
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
                                                <xsl:if test="string(boolean($var_LearnPlanEndDate)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LearnPlanEndDate</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_LearnPlanEndDate)"/>
                                                        </date-val>
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
                                                <xsl:if test="string(boolean($var_LrnDelFAM_ADL)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LrnDelFAM_ADL</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_LrnDelFAM_ADL)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LrnDelFAM_EEF)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LrnDelFAM_EEF</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_LrnDelFAM_EEF)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LrnDelFAM_FFI)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LrnDelFAM_FFI</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_LrnDelFAM_FFI)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LrnDelFAM_LDM1)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LrnDelFAM_LDM1</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_LrnDelFAM_LDM1)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LrnDelFAM_LDM2)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LrnDelFAM_LDM2</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_LrnDelFAM_LDM2)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LrnDelFAM_LDM3)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LrnDelFAM_LDM3</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_LrnDelFAM_LDM3)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LrnDelFAM_LDM4)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LrnDelFAM_LDM4</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_LrnDelFAM_LDM4)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LrnDelFAM_RES)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LrnDelFAM_RES</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_LrnDelFAM_RES)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LrnDelFAM_SOF)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LrnDelFAM_SOF</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_LrnDelFAM_SOF)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LrnDelFAM_SPP)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LrnDelFAM_SPP</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_LrnDelFAM_SPP)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_NotionalNVQLevel)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">NotionalNVQLevel</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_NotionalNVQLevel)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_NotionalNVQLevelv2)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">NotionalNVQLevelv2</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_NotionalNVQLevelv2)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_OrigLearnStartDate)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">OrigLearnStartDate</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_OrigLearnStartDate)"/>
                                                        </date-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_Outcome)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">Outcome</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_Outcome)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_OutGrade)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">OutGrade</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_OutGrade)"/>
                                                        </text-val>
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
                                                <xsl:if test="string(boolean($var_PwayCode)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">PwayCode</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_PwayCode)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_RegulatedCreditValue)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">RegulatedCreditValue</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_RegulatedCreditValue)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_Section96Valid16to18)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">Section96Valid16to18</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_Section96Valid16to18)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_SectorSubjectAreaTier1)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">SectorSubjectAreaTier1</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_SectorSubjectAreaTier1)"/>
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
                                                <xsl:if test="string(boolean($var_SFA_CalcFundingLineType)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">SFA_CalcFundingLineType</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_SFA_CalcFundingLineType)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_SFA_CalcLargeEmpFactor)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">SFA_CalcLargeEmpFactor</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_SFA_CalcLargeEmpFactor)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_SFA_CalcStartFunding)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">SFA_CalcStartFunding</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_SFA_CalcStartFunding)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_SFA_CalcThresholdDays)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">SFA_CalcThresholdDays</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_SFA_CalcThresholdDays)"/>
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
                                                        <xsl:variable name="var_LearnDelFAMDateFrom"
                                                                      select="@LearnDelFAMDateFrom"/>
                                                        <xsl:variable name="var_LearnDelFAMDateTo"
                                                                      select="@LearnDelFAMDateTo"/>
                                                        <xsl:variable name="var_LearnDelFAMType"
                                                                      select="@LearnDelFAMType"/>
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
                                                            <xsl:if test="string(boolean($var_LearnDelFAMType)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LearnDelFAMType</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_LearnDelFAMType)"/>
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
                                                    <xsl:attribute name="id">LARSAnnualValue</xsl:attribute>
                                                    <xsl:attribute name="complete">
                                                        <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                    </xsl:attribute>
                                                    <xsl:for-each select="LARSAnnualValue">
                                                        <xsl:variable name="var_BasicSkills"
                                                                      select="@BasicSkills"/>
                                                        <xsl:variable name="var_BasicSkillsParticipation"
                                                                      select="@BasicSkillsParticipation"/>
                                                        <xsl:variable name="var_BasicSkillsType"
                                                                      select="@BasicSkillsType"/>
                                                        <xsl:variable name="var_EffectiveFrom"
                                                                      select="@EffectiveFrom"/>
                                                        <xsl:variable name="var_EffectiveTo"
                                                                      select="@EffectiveTo"/>
                                                        <xsl:variable name="var_FullLevel2EntitlementCategory"
                                                                      select="@FullLevel2EntitlementCategory"/>
                                                        <xsl:variable name="var_FullLevel2Percent"
                                                                      select="@FullLevel2Percent"/>
                                                        <xsl:variable name="var_FullLevel3EntitlementCategory"
                                                                      select="@FullLevel3EntitlementCategory"/>
                                                        <xsl:variable name="var_FullLevel3Percent"
                                                                      select="@FullLevel3Percent"/>
                                                        <xsl:variable name="var_SFAApprovalStatus"
                                                                      select="@SFAApprovalStatus"/>
                                                        <instance>
                                                            <xsl:attribute name="id">
                                                                <xsl:value-of select="generate-id(.)"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string(boolean($var_BasicSkills)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">BasicSkills</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_BasicSkills)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_BasicSkillsParticipation)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">BasicSkillsParticipation</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_BasicSkillsParticipation)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_BasicSkillsType)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">BasicSkillsType</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_BasicSkillsType)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
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
                                                            <xsl:if test="string(boolean($var_FullLevel2EntitlementCategory)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">FullLevel2EntitlementCategory</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_FullLevel2EntitlementCategory)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_FullLevel2Percent)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">FullLevel2Percent</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_FullLevel2Percent)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_FullLevel3EntitlementCategory)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">FullLevel3EntitlementCategory</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_FullLevel3EntitlementCategory)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_FullLevel3Percent)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">FullLevel3Percent</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_FullLevel3Percent)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_SFAApprovalStatus)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">SFAApprovalStatus</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_SFAApprovalStatus)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                        </instance>
                                                    </xsl:for-each>
                                                </entity>
                                                <entity>
                                                    <xsl:attribute name="id">
                                                        <xsl:value-of select="generate-id(.)"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="id">LearningDeliveryHE</xsl:attribute>
                                                    <xsl:attribute name="complete">
                                                        <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                    </xsl:attribute>
                                                    <xsl:for-each select="LearningDeliveryHE">
                                                        <xsl:variable name="var_TYPEYR"
                                                                      select="@TYPEYR"/>
                                                        <instance>
                                                            <xsl:attribute name="id">
                                                                <xsl:value-of select="generate-id(.)"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string(boolean($var_TYPEYR)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">TYPEYR</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_TYPEYR)"/>
                                                                    </number-val>
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
                                                        <xsl:variable name="var_ValidityEndDate"
                                                                      select="@ValidityEndDate"/>
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
                                                            <xsl:if test="string(boolean($var_ValidityEndDate)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">ValidityEndDate</xsl:attribute>
                                                                    <date-val>
                                                                        <xsl:value-of select="string($var_ValidityEndDate)"/>
                                                                    </date-val>
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
                                    <entity>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="generate-id(.)"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="id">LLDDandHealthProblem</xsl:attribute>
                                        <xsl:attribute name="complete">
                                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                        </xsl:attribute>
                                        <xsl:for-each select="LLDDandHealthProblem">
                                            <xsl:variable name="var_LLDDCat"
                                                          select="@LLDDCat"/>
                                            <xsl:variable name="var_PrimaryLLDD"
                                                          select="@PrimaryLLDD"/>
                                            <instance>
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="generate-id(.)"/>
                                                </xsl:attribute>
                                                <xsl:if test="string(boolean($var_LLDDCat)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LLDDCat</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_LLDDCat)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_PrimaryLLDD)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">PrimaryLLDD</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_PrimaryLLDD)"/>
                                                        </number-val>
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

        </session-data>
    </xsl:template>
</xsl:stylesheet>
