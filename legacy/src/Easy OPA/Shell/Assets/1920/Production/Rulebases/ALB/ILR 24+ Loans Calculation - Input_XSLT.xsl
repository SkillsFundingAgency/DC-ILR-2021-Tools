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
                    <xsl:variable name="var_PostcodeAreaCostVersion"
                                  select="@PostcodeAreaCostVersion"/>
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
                        <xsl:if test="string(boolean($var_PostcodeAreaCostVersion)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">PostcodeAreaCostVersion</xsl:attribute>
                                <text-val>
                                    <xsl:value-of select="string($var_PostcodeAreaCostVersion)"/>
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
                                <xsl:variable name="var_LearnRefNumber"
                                              select="@LearnRefNumber"/>
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
                                    <entity>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="generate-id(.)"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="id">LearningDelivery</xsl:attribute>
                                        <xsl:attribute name="complete">
                                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                        </xsl:attribute>
                                        <xsl:for-each select="LearningDelivery">
                                            <xsl:variable name="var_LearnDelFundModel"
                                                          select="@LearnDelFundModel"/>
                                            <xsl:variable name="var_LearnAimRefType"
                                                          select="@LearnAimRefType"/>
                                            <xsl:variable name="var_AimSeqNumber"
                                                          select="@AimSeqNumber"/>
                                            <xsl:variable name="var_CompStatus"
                                                          select="@CompStatus"/>
                                            <xsl:variable name="var_Outcome"
                                                          select="@Outcome"/>
                                            <xsl:variable name="var_LearnStartDate"
                                                          select="@LearnStartDate"/>
                                            <xsl:variable name="var_LearnPlanEndDate"
                                                          select="@LearnPlanEndDate"/>
                                            <xsl:variable name="var_LearnActEndDate"
                                                          select="@LearnActEndDate"/>
                                            <xsl:variable name="var_OrigLearnStartDate"
                                                          select="@OrigLearnStartDate"/>
                                            <xsl:variable name="var_NotionalNVQLevelv2"
                                                          select="@NotionalNVQLevelv2"/>
                                            <xsl:variable name="var_RegulatedCreditValue"
                                                          select="@RegulatedCreditValue"/>
                                            <xsl:variable name="var_PriorLearnFundAdj"
                                                          select="@PriorLearnFundAdj"/>
                                            <xsl:variable name="var_OtherFundAdj"
                                                          select="@OtherFundAdj"/>
                                            <instance>
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="generate-id(.)"/>
                                                </xsl:attribute>
                                                <xsl:if test="string(boolean($var_LearnDelFundModel)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LearnDelFundModel</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_LearnDelFundModel)"/>
                                                        </number-val>
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
                                                <xsl:if test="string(boolean($var_AimSeqNumber)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">AimSeqNumber</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_AimSeqNumber)"/>
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
                                                <xsl:if test="string(boolean($var_Outcome)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">Outcome</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_Outcome)"/>
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
                                                <xsl:if test="string(boolean($var_OrigLearnStartDate)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">OrigLearnStartDate</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_OrigLearnStartDate)"/>
                                                        </date-val>
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
                                                <xsl:if test="string(boolean($var_RegulatedCreditValue)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">RegulatedCreditValue</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_RegulatedCreditValue)"/>
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
                                                <xsl:if test="string(boolean($var_OtherFundAdj)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">OtherFundAdj</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_OtherFundAdj)"/>
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
                                                <entity>
                                                    <xsl:attribute name="id">
                                                        <xsl:value-of select="generate-id(.)"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="id">LearningDeliveryLARS_Funding</xsl:attribute>
                                                    <xsl:attribute name="complete">
                                                        <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                    </xsl:attribute>
                                                    <xsl:for-each select="LearningDeliveryLARS_Funding">
                                                        <xsl:variable name="var_LARSFundCategory"
                                                                      select="@LARSFundCategory"/>
                                                        <xsl:variable name="var_LARSFundEffectiveFrom"
                                                                      select="@LARSFundEffectiveFrom"/>
                                                        <xsl:variable name="var_LARSFundEffectiveTo"
                                                                      select="@LARSFundEffectiveTo"/>
                                                        <xsl:variable name="var_LARSFundWeightedRate"
                                                                      select="@LARSFundWeightedRate"/>
                                                        <xsl:variable name="var_LARSFundWeightingFactor"
                                                                      select="@LARSFundWeightingFactor"/>
                                                        <instance>
                                                            <xsl:attribute name="id">
                                                                <xsl:value-of select="generate-id(.)"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string(boolean($var_LARSFundCategory)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LARSFundCategory</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_LARSFundCategory)"/>
                                                                    </text-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_LARSFundEffectiveFrom)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LARSFundEffectiveFrom</xsl:attribute>
                                                                    <date-val>
                                                                        <xsl:value-of select="string($var_LARSFundEffectiveFrom)"/>
                                                                    </date-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_LARSFundEffectiveTo)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LARSFundEffectiveTo</xsl:attribute>
                                                                    <date-val>
                                                                        <xsl:value-of select="string($var_LARSFundEffectiveTo)"/>
                                                                    </date-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_LARSFundWeightedRate)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LARSFundWeightedRate</xsl:attribute>
                                                                    <currency-val>
                                                                        <xsl:value-of select="string($var_LARSFundWeightedRate)"/>
                                                                    </currency-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_LARSFundWeightingFactor)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LARSFundWeightingFactor</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_LARSFundWeightingFactor)"/>
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
                    </instance>
                </xsl:for-each>
            </entity>
        </session-data>
    </xsl:template>
</xsl:stylesheet>
