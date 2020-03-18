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
                <xsl:variable name="var_LearnRefNumber"
                              select="@LearnRefNumber"/>
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
                  <xsl:if test="string(boolean($var_LearnRefNumber)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">LearnRefNumber</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="string($var_LearnRefNumber)"/>
                      </text-val>
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
                      <xsl:variable name="var_DateEmpStatApp" select="@DateEmpStatApp"/>
                      <xsl:variable name="var_EMPStat" select="@EMPStat"/>
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
                        <xsl:if test="string(boolean($var_EMPStat)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">EMPStat</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_EMPStat)"/>
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
                    <xsl:attribute name="id">LearningDelivery</xsl:attribute>
                    <xsl:attribute name="complete">
                      <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                    </xsl:attribute>
                    <xsl:for-each select="LearningDelivery">
                      <xsl:variable name="var_AchDate"
                                    select="@AchDate"/>
                      <xsl:variable name="var_AddHours"
                                    select="@AddHours"/>
                      <xsl:variable name="var_AimSeqNumber"
                                    select="@AimSeqNumber"/>
                      <xsl:variable name="var_CalcMethod"
                                    select="@CalcMethod"/>
                      <xsl:variable name="var_CompStatus"
                                    select="@CompStatus"/>
                      <xsl:variable name="var_ConRefNumber"
                                    select="@ConRefNumber"/>
                      <xsl:variable name="var_GenreCode"
                                    select="@GenreCode"/>
                      <xsl:variable name="var_LearnActEndDate"
                                    select="@LearnActEndDate"/>
                      <xsl:variable name="var_LearnAimRef"
                                    select="@LearnAimRef"/>
                      <xsl:variable name="var_LearnPlanEndDate"
                                    select="@LearnPlanEndDate"/>
                      <xsl:variable name="var_LearnStartDate"
                                    select="@LearnStartDate"/>
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
                      <xsl:variable name="var_OrigLearnStartDate"
                                    select="@OrigLearnStartDate"/>
                      <xsl:variable name="var_OtherFundAdj"
                                    select="@OtherFundAdj"/>
                      <xsl:variable name="var_Outcome"
                                    select="@Outcome"/>
                      <xsl:variable name="var_PriorLearnFundAdj"
                                    select="@PriorLearnFundAdj"/>
                      <instance>
                        <xsl:attribute name="id">
                          <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_AchDate)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">AchDate</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_AchDate)"/>
                            </date-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_AddHours)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">AddHours</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_AddHours)"/>
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
                        <xsl:if test="string(boolean($var_CalcMethod)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">CalcMethod</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_CalcMethod)"/>
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
                        <xsl:if test="string(boolean($var_ConRefNumber)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">ConRefNumber</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_ConRefNumber)"/>
                            </text-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_GenreCode)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">GenreCode</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_GenreCode)"/>
                            </text-val>
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
                        <xsl:if test="string(boolean($var_OrigLearnStartDate)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">OrigLearnStartDate</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_OrigLearnStartDate)"/>
                            </date-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_OtherFundAdj)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">OtherFundAdj</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_OtherFundAdj)"/>
                            </number-val>
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
                        <xsl:if test="string(boolean($var_PriorLearnFundAdj)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">PriorLearnFundAdj</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_PriorLearnFundAdj)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>
                        <entity>
                          <xsl:attribute name="id">
                            <xsl:value-of select="generate-id(.)"/>
                          </xsl:attribute>
                          <xsl:attribute name="id">ESFData</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="ESFData">
                            <xsl:variable name="var_EffectiveContractEndDate"
                                          select="@EffectiveContractEndDate"/>
                            <xsl:variable name="var_EffectiveContractStartDate"
                                          select="@EffectiveContractStartDate"/>
                            <xsl:variable name="var_ESFDataPremiumFactor"
                                          select="@ESFDataPremiumFactor"/>
                            <xsl:variable name="var_ESFDeliverableCode"
                                          select="@ESFDeliverableCode"/>
                            <xsl:variable name="var_UnitCost"
                                          select="@UnitCost"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_EffectiveContractEndDate)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">EffectiveContractEndDate</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_EffectiveContractEndDate)"/>
                                  </date-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_EffectiveContractStartDate)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">EffectiveContractStartDate</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_EffectiveContractStartDate)"/>
                                  </date-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_ESFDataPremiumFactor)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">ESFDataPremiumFactor</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_ESFDataPremiumFactor)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_ESFDeliverableCode)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">ESFDeliverableCode</xsl:attribute>
                                  <text-val>
                                    <xsl:value-of select="string($var_ESFDeliverableCode)"/>
                                  </text-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_UnitCost)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">UnitCost</xsl:attribute>
                                  <currency-val>
                                    <xsl:value-of select="string($var_UnitCost)"/>
                                  </currency-val>
                                </attribute>
                              </xsl:if>
                            </instance>
                          </xsl:for-each>
                        </entity>
                        <entity>
                          <xsl:attribute name="id">
                            <xsl:value-of select="generate-id(.)"/>
                          </xsl:attribute>
                          <xsl:attribute name="id">LearningDeliveryLARSFunding</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="LearningDeliveryLARSFunding">
                            <xsl:variable name="var_LARSFundingCategory"
                                          select="@LARSFundingCategory"/>
                            <xsl:variable name="var_LARSFundingEffectiveFrom"
                                          select="@LARSFundingEffectiveFrom"/>
                            <xsl:variable name="var_LARSFundingEffectiveTo"
                                          select="@LARSFundingEffectiveTo"/>
                            <xsl:variable name="var_LARSFundingWeightedRate"
                                          select="@LARSFundingWeightedRate"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_LARSFundingCategory)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LARSFundingCategory</xsl:attribute>
                                  <text-val>
                                    <xsl:value-of select="string($var_LARSFundingCategory)"/>
                                  </text-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_LARSFundingEffectiveFrom)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LARSFundingEffectiveFrom</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_LARSFundingEffectiveFrom)"/>
                                  </date-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_LARSFundingEffectiveTo)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LARSFundingEffectiveTo</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_LARSFundingEffectiveTo)"/>
                                  </date-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_LARSFundingWeightedRate)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LARSFundingWeightedRate</xsl:attribute>
                                  <currency-val>
                                    <xsl:value-of select="string($var_LARSFundingWeightedRate)"/>
                                  </currency-val>
                                </attribute>
                              </xsl:if>
                            </instance>
                          </xsl:for-each>
                        </entity>
                        <entity>
                          <xsl:attribute name="id">
                            <xsl:value-of select="generate-id(.)"/>
                          </xsl:attribute>
                          <xsl:attribute name="id">LearningDeliveryAnnualValue</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="LearningDeliveryAnnualValue">
                            <xsl:variable name="var_LearnDelAnnValBasicSkillsTypeCode"
                                          select="@LearnDelAnnValBasicSkillsTypeCode"/>
                            <xsl:variable name="var_LearnDelAnnValDateFrom"
                                          select="@LearnDelAnnValDateFrom"/>
                            <xsl:variable name="var_LearnDelAnnValDateTo"
                                          select="@LearnDelAnnValDateTo"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_LearnDelAnnValBasicSkillsTypeCode)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LearnDelAnnValBasicSkillsTypeCode</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_LearnDelAnnValBasicSkillsTypeCode)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_LearnDelAnnValDateFrom)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LearnDelAnnValDateFrom</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_LearnDelAnnValDateFrom)"/>
                                  </date-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_LearnDelAnnValDateTo)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LearnDelAnnValDateTo</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_LearnDelAnnValDateTo)"/>
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
                          <xsl:attribute name="id">SFA_PostcodeAreaCost</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="SFA_PostcodeAreaCost">
                            <xsl:variable name="var_AreaCosEffectiveFrom"
                                          select="@AreaCosEffectiveFrom"/>
                            <xsl:variable name="var_AreaCosEffectiveTo"
                                          select="@AreaCosEffectiveTo"/>
                            <xsl:variable name="var_AreaCosFactor"
                                          select="@AreaCosFactor"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_AreaCosEffectiveFrom)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">AreaCosEffectiveFrom</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_AreaCosEffectiveFrom)"/>
                                  </date-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_AreaCosEffectiveTo)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">AreaCosEffectiveTo</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_AreaCosEffectiveTo)"/>
                                  </date-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_AreaCosFactor)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">AreaCosFactor</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_AreaCosFactor)"/>
                                  </number-val>
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
                    <xsl:attribute name="id">DPOutcome</xsl:attribute>
                    <xsl:attribute name="complete">
                      <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                    </xsl:attribute>
                    <xsl:for-each select="DPOutcome">
                      <xsl:variable name="var_OutCode"
                                    select="@OutCode"/>
                      <xsl:variable name="var_OutCollDate"
                                    select="@OutCollDate"/>
                      <xsl:variable name="var_OutEndDate"
                                    select="@OutEndDate"/>
                      <xsl:variable name="var_OutStartDate"
                                    select="@OutStartDate"/>
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
                        <xsl:if test="string(boolean($var_OutCollDate)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">OutCollDate</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_OutCollDate)"/>
                            </date-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_OutEndDate)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">OutEndDate</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_OutEndDate)"/>
                            </date-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_OutStartDate)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">OutStartDate</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_OutStartDate)"/>
                            </date-val>
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
                </instance>
              </xsl:for-each>
            </entity>
          </instance>
        </xsl:for-each>
      </entity>
    </session-data>
  </xsl:template>
</xsl:stylesheet>
