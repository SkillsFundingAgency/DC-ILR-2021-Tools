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
                    <xsl:variable name="var_LARSVersion"
                                  select="@LARSVersion"/>
                    <xsl:variable name="var_UKPRN"
                                  select="@UKPRN"/>
                    <instance>
                        <xsl:attribute name="id">
                            <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_LARSVersion)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">LARSVersion</xsl:attribute>
                                <text-val>
                                    <xsl:value-of select="string($var_LARSVersion)"/>
                                </text-val>
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
                                        <xsl:attribute name="id">LearningDelivery</xsl:attribute>
                                        <xsl:attribute name="complete">
                                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                        </xsl:attribute>
                                        <xsl:for-each select="LearningDelivery">
                                            <xsl:variable name="var_AchDate"
                                                          select="@AchDate"/>
                                            <xsl:variable name="var_AimSeqNumber"
                                                          select="@AimSeqNumber"/>
                                            <xsl:variable name="var_AimType"
                                                          select="@AimType"/>
                                            <xsl:variable name="var_CompStatus"
                                                          select="@CompStatus"/>
                                            <xsl:variable name="var_FrameworkCommonComponent"
                                                          select="@FrameworkCommonComponent"/>
                                            <xsl:variable name="var_LearnActEndDate"
                                                          select="@LearnActEndDate"/>
                                            <xsl:variable name="var_LearnAimRef"
                                                          select="@LearnAimRef"/>
                                            <xsl:variable name="var_LearnPlanEndDate"
                                                          select="@LearnPlanEndDate"/>
                                            <xsl:variable name="var_LearnStartDate"
                                                          select="@LearnStartDate"/>
                                            <xsl:variable name="var_OrigLearnStartDate"
                                                          select="@OrigLearnStartDate"/>
                                            <xsl:variable name="var_OtherFundAdj"
                                                          select="@OtherFundAdj"/>
                                            <xsl:variable name="var_Outcome"
                                                          select="@Outcome"/>
                                            <xsl:variable name="var_PriorLearnFundAdj"
                                                          select="@PriorLearnFundAdj"/>
                                            <xsl:variable name="var_ProgType"
                                                          select="@ProgType"/>
                                            <xsl:variable name="var_STDCode"
                                                          select="@STDCode"/>
                                            <xsl:variable name="var_WithdrawReason"
                                                          select="@WithdrawReason"/>
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
                                                <xsl:if test="string(boolean($var_CompStatus)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">CompStatus</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_CompStatus)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_FrameworkCommonComponent)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">FrameworkCommonComponent</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_FrameworkCommonComponent)"/>
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
                                                <xsl:if test="string(boolean($var_ProgType)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">ProgType</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_ProgType)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_STDCode)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">STDCode</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_STDCode)"/>
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
                                                    <xsl:attribute name="id">ApprenticeshipFinancialRecord</xsl:attribute>
                                                    <xsl:attribute name="complete">
                                                        <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                    </xsl:attribute>
                                                    <xsl:for-each select="ApprenticeshipFinancialRecord">
                                                        <xsl:variable name="var_AFinAmount"
                                                                      select="@AFinAmount"/>
                                                        <xsl:variable name="var_AFinCode"
                                                                      select="@AFinCode"/>
                                                        <xsl:variable name="var_AFinDate"
                                                                      select="@AFinDate"/>
                                                        <xsl:variable name="var_AFinType"
                                                                      select="@AFinType"/>
                                                        <instance>
                                                            <xsl:attribute name="id">
                                                                <xsl:value-of select="generate-id(.)"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string(boolean($var_AFinAmount)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">AFinAmount</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_AFinAmount)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_AFinCode)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">AFinCode</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_AFinCode)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_AFinDate)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">AFinDate</xsl:attribute>
                                                                    <date-val>
                                                                        <xsl:value-of select="string($var_AFinDate)"/>
                                                                    </date-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_AFinType)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">AFinType</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_AFinType)"/>
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
                                                    <xsl:attribute name="id">LARS_StandardCommonComponent</xsl:attribute>
                                                    <xsl:attribute name="complete">
                                                        <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                    </xsl:attribute>
                                                    <xsl:for-each select="LARS_StandardCommonComponent">
                                                        <xsl:variable name="var_LARSCommonComponent"
                                                                      select="@LARSCommonComponent"/>
                                                        <xsl:variable name="var_LARSEffectiveFrom"
                                                                      select="@LARSEffectiveFrom"/>
                                                        <xsl:variable name="var_LARSEffectiveTo"
                                                                      select="@LARSEffectiveTo"/>
                                                        <xsl:variable name="var_LARSStandardCode"
                                                                      select="@LARSStandardCode"/>
                                                        <instance>
                                                            <xsl:attribute name="id">
                                                                <xsl:value-of select="generate-id(.)"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string(boolean($var_LARSCommonComponent)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LARSCommonComponent</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_LARSCommonComponent)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_LARSEffectiveFrom)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LARSEffectiveFrom</xsl:attribute>
                                                                    <date-val>
                                                                        <xsl:value-of select="string($var_LARSEffectiveFrom)"/>
                                                                    </date-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_LARSEffectiveTo)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LARSEffectiveTo</xsl:attribute>
                                                                    <date-val>
                                                                        <xsl:value-of select="string($var_LARSEffectiveTo)"/>
                                                                    </date-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_LARSStandardCode)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LARSStandardCode</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_LARSStandardCode)"/>
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
                                                    <xsl:attribute name="id">LARS_StandardFunding</xsl:attribute>
                                                    <xsl:attribute name="complete">
                                                        <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                    </xsl:attribute>
                                                    <xsl:for-each select="LARS_StandardFunding">
                                                        <xsl:variable name="var_FundableWithoutEmployer"
                                                                      select="@FundableWithoutEmployer"/>
                                                        <xsl:variable name="var_SF1618Incentive"
                                                                      select="@SF1618Incentive"/>
                                                        <xsl:variable name="var_SFAchIncentive"
                                                                      select="@SFAchIncentive"/>
                                                        <xsl:variable name="var_SFCoreGovContCap"
                                                                      select="@SFCoreGovContCap"/>
                                                        <xsl:variable name="var_SFEffectiveFromDate"
                                                                      select="@SFEffectiveFromDate"/>
                                                        <xsl:variable name="var_SFEffectiveToDate"
                                                                      select="@SFEffectiveToDate"/>
                                                        <xsl:variable name="var_SFSmallBusIncentive"
                                                                      select="@SFSmallBusIncentive"/>
                                                        <instance>
                                                            <xsl:attribute name="id">
                                                                <xsl:value-of select="generate-id(.)"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string(boolean($var_FundableWithoutEmployer)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">FundableWithoutEmployer</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_FundableWithoutEmployer)"/>
                                                                    </text-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_SF1618Incentive)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">SF1618Incentive</xsl:attribute>
                                                                    <currency-val>
                                                                        <xsl:value-of select="string($var_SF1618Incentive)"/>
                                                                    </currency-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_SFAchIncentive)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">SFAchIncentive</xsl:attribute>
                                                                    <currency-val>
                                                                        <xsl:value-of select="string($var_SFAchIncentive)"/>
                                                                    </currency-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_SFCoreGovContCap)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">SFCoreGovContCap</xsl:attribute>
                                                                    <currency-val>
                                                                        <xsl:value-of select="string($var_SFCoreGovContCap)"/>
                                                                    </currency-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_SFEffectiveFromDate)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">SFEffectiveFromDate</xsl:attribute>
                                                                    <date-val>
                                                                        <xsl:value-of select="string($var_SFEffectiveFromDate)"/>
                                                                    </date-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_SFEffectiveToDate)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">SFEffectiveToDate</xsl:attribute>
                                                                    <date-val>
                                                                        <xsl:value-of select="string($var_SFEffectiveToDate)"/>
                                                                    </date-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_SFSmallBusIncentive)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">SFSmallBusIncentive</xsl:attribute>
                                                                    <currency-val>
                                                                        <xsl:value-of select="string($var_SFSmallBusIncentive)"/>
                                                                    </currency-val>
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
                                        <xsl:attribute name="id">LearnerEmploymentStatus</xsl:attribute>
                                        <xsl:attribute name="complete">
                                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                        </xsl:attribute>
                                        <xsl:for-each select="LearnerEmploymentStatus">
                                            <xsl:variable name="var_DateEmpStatApp"
                                                          select="@DateEmpStatApp"/>
                                            <xsl:variable name="var_EmpId"
                                                          select="@EmpId"/>
                                            <xsl:variable name="var_EMPStat"
                                                          select="@EMPStat"/>
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
                                                <xsl:if test="string(boolean($var_EMPStat)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EMPStat</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_EMPStat)"/>
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
                                </instance>
                            </xsl:for-each>
                        </entity>
                    </instance>
                </xsl:for-each>
            </entity>
        </session-data>
    </xsl:template>
</xsl:stylesheet>
