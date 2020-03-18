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
                    <xsl:variable name="var_DesktopMode"
                                  select="@DesktopMode"/>
                    <xsl:variable name="var_UKPRN"
                                  select="@UKPRN"/>
                    <instance>
                        <xsl:attribute name="id">
                            <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_DesktopMode)) != 'false'">
                            <attribute>
                                <xsl:attribute name="id">DesktopMode</xsl:attribute>
                                <boolean-val>
                                    <xsl:value-of select="string($var_DesktopMode)"/>
                                </boolean-val>
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
                                <xsl:variable name="var_PriorAttain"
                                              select="@PriorAttain"/>
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
                                    <xsl:if test="string(boolean($var_PriorAttain)) != 'false'">
                                        <attribute>
                                            <xsl:attribute name="id">PriorAttain</xsl:attribute>
                                            <number-val>
                                                <xsl:value-of select="string($var_PriorAttain)"/>
                                            </number-val>
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
                                            <xsl:variable name="var_AimSeqNumber"
                                                          select="@AimSeqNumber"/>
                                            <xsl:variable name="var_AimType"
                                                          select="@AimType"/>
                                            <xsl:variable name="var_CompStatus"
                                                          select="@CompStatus"/>
                                            <xsl:variable name="var_ConRefNumber"
                                                          select="@ConRefNumber"/>
                                            <xsl:variable name="var_ConRefStartDate"
                                                          select="@ConRefStartDate"/>
                                            <xsl:variable name="var_DelLocPostcode"
                                                          select="@DelLocPostcode"/>
                                            <xsl:variable name="var_EmpOutcome"
                                                          select="@EmpOutcome"/>
                                            <xsl:variable name="var_FundModel"
                                                          select="@FundModel"/>
                                            <xsl:variable name="var_FworkCode"
                                                          select="@FworkCode"/>
                                            <xsl:variable name="var_LARS_SectorSubjectAreaTier1"
                                                          select="@LARS_SectorSubjectAreaTier1"/>
                                            <xsl:variable name="var_LARS_SectorSubjectAreaTier2"
                                                          select="@LARS_SectorSubjectAreaTier2"/>
                                            <xsl:variable name="var_LearnActEndDate"
                                                          select="@LearnActEndDate"/>
                                            <xsl:variable name="var_LearnAimRef"
                                                          select="@LearnAimRef"/>
                                            <xsl:variable name="var_LearnPlanEndDate"
                                                          select="@LearnPlanEndDate"/>
                                            <xsl:variable name="var_LearnStartDate"
                                                          select="@LearnStartDate"/>
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
                                            <xsl:variable name="var_UnemployedOnly"
                                                          select="@UnemployedOnly"/>
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
                                                <xsl:if test="string(boolean($var_ConRefStartDate)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">ConRefStartDate</xsl:attribute>
                                                        <date-val>
                                                            <xsl:value-of select="string($var_ConRefStartDate)"/>
                                                        </date-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_DelLocPostcode)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">DelLocPostcode</xsl:attribute>
                                                        <text-val>
                                                            <xsl:value-of select="string($var_DelLocPostcode)"/>
                                                        </text-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_EmpOutcome)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EmpOutcome</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_EmpOutcome)"/>
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
                                                <xsl:if test="string(boolean($var_LARS_SectorSubjectAreaTier1)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LARS_SectorSubjectAreaTier1</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_LARS_SectorSubjectAreaTier1)"/>
                                                        </number-val>
                                                    </attribute>
                                                </xsl:if>
                                                <xsl:if test="string(boolean($var_LARS_SectorSubjectAreaTier2)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">LARS_SectorSubjectAreaTier2</xsl:attribute>
                                                        <number-val>
                                                            <xsl:value-of select="string($var_LARS_SectorSubjectAreaTier2)"/>
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
                                                <xsl:if test="string(boolean($var_UnemployedOnly)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">UnemployedOnly</xsl:attribute>
                                                        <boolean-val>
                                                            <xsl:value-of select="string($var_UnemployedOnly)"/>
                                                        </boolean-val>
                                                    </attribute>
                                                </xsl:if>
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
                                                    <xsl:attribute name="id">EligibilityRule</xsl:attribute>
                                                    <xsl:attribute name="complete">
                                                        <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                    </xsl:attribute>
                                                    <xsl:for-each select="EligibilityRule">
                                                        <xsl:variable name="var_Benefits"
                                                                      select="@Benefits"/>
                                                        <xsl:variable name="var_MaxAge"
                                                                      select="@MaxAge"/>
                                                        <xsl:variable name="var_MaxLengthOfUnemployment"
                                                                      select="@MaxLengthOfUnemployment"/>
                                                        <xsl:variable name="var_MaxPriorAttainment"
                                                                      select="@MaxPriorAttainment"/>
                                                        <xsl:variable name="var_MinAge"
                                                                      select="@MinAge"/>
                                                        <xsl:variable name="var_MinLengthOfUnemployment"
                                                                      select="@MinLengthOfUnemployment"/>
                                                        <xsl:variable name="var_MinPriorAttainment"
                                                                      select="@MinPriorAttainment"/>
                                                        <instance>
                                                            <xsl:attribute name="id">
                                                                <xsl:value-of select="generate-id(.)"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string(boolean($var_Benefits)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">Benefits</xsl:attribute>
                                                                    <boolean-val>
                                                                        <xsl:value-of select="string($var_Benefits)"/>
                                                                    </boolean-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_MaxAge)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">MaxAge</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_MaxAge)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_MaxLengthOfUnemployment)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">MaxLengthOfUnemployment</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_MaxLengthOfUnemployment)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_MaxPriorAttainment)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">MaxPriorAttainment</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_MaxPriorAttainment)"/>
                                                                    </text-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_MinAge)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">MinAge</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_MinAge)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_MinLengthOfUnemployment)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">MinLengthOfUnemployment</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_MinLengthOfUnemployment)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_MinPriorAttainment)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">MinPriorAttainment</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_MinPriorAttainment)"/>
                                                                    </text-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <entity>
                                                                <xsl:attribute name="id">
                                                                    <xsl:value-of select="generate-id(.)"/>
                                                                </xsl:attribute>
                                                                <xsl:attribute name="id">EligibilityRuleEmploymentStatus</xsl:attribute>
                                                                <xsl:attribute name="complete">
                                                                    <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                                </xsl:attribute>
                                                                <xsl:for-each select="EligibilityRuleEmploymentStatus">
                                                                    <xsl:variable name="var_EmploymentStatusCode"
                                                                                  select="@EmploymentStatusCode"/>
                                                                    <instance>
                                                                        <xsl:attribute name="id">
                                                                            <xsl:value-of select="generate-id(.)"/>
                                                                        </xsl:attribute>
                                                                        <xsl:if test="string(boolean($var_EmploymentStatusCode)) != 'false'">
                                                                            <attribute>
                                                                                <xsl:attribute name="id">EmploymentStatusCode</xsl:attribute>
                                                                                <number-val>
                                                                                    <xsl:value-of select="string($var_EmploymentStatusCode)"/>
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
                                                                <xsl:attribute name="id">EligibilityRuleLocalAuthority</xsl:attribute>
                                                                <xsl:attribute name="complete">
                                                                    <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                                </xsl:attribute>
                                                                <xsl:for-each select="EligibilityRuleLocalAuthority">
                                                                    <xsl:variable name="var_LocalAuthorityCode"
                                                                                  select="@LocalAuthorityCode"/>
                                                                    <instance>
                                                                        <xsl:attribute name="id">
                                                                            <xsl:value-of select="generate-id(.)"/>
                                                                        </xsl:attribute>
                                                                        <xsl:if test="string(boolean($var_LocalAuthorityCode)) != 'false'">
                                                                            <attribute>
                                                                                <xsl:attribute name="id">LocalAuthorityCode</xsl:attribute>
                                                                                <text-val>
                                                                                    <xsl:value-of select="string($var_LocalAuthorityCode)"/>
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
                                                                <xsl:attribute name="id">EligibilityRuleLocalEnterprisePartnership</xsl:attribute>
                                                                <xsl:attribute name="complete">
                                                                    <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                                </xsl:attribute>
                                                                <xsl:for-each select="EligibilityRuleLocalEnterprisePartnership">
                                                                    <xsl:variable name="var_LocalEnterprisePartnershipCode"
                                                                                  select="@LocalEnterprisePartnershipCode"/>
                                                                    <instance>
                                                                        <xsl:attribute name="id">
                                                                            <xsl:value-of select="generate-id(.)"/>
                                                                        </xsl:attribute>
                                                                        <xsl:if test="string(boolean($var_LocalEnterprisePartnershipCode)) != 'false'">
                                                                            <attribute>
                                                                                <xsl:attribute name="id">LocalEnterprisePartnershipCode</xsl:attribute>
                                                                                <text-val>
                                                                                    <xsl:value-of select="string($var_LocalEnterprisePartnershipCode)"/>
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
                                                                <xsl:attribute name="id">EligibilityRuleSectorSubjectAreaLevel</xsl:attribute>
                                                                <xsl:attribute name="complete">
                                                                    <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                                </xsl:attribute>
                                                                <xsl:for-each select="EligibilityRuleSectorSubjectAreaLevel">
                                                                    <xsl:variable name="var_MaxLevelCode"
                                                                                  select="@MaxLevelCode"/>
                                                                    <xsl:variable name="var_MinLevelCode"
                                                                                  select="@MinLevelCode"/>
                                                                    <xsl:variable name="var_SectorSubjectAreaCode"
                                                                                  select="@SectorSubjectAreaCode"/>
                                                                    <instance>
                                                                        <xsl:attribute name="id">
                                                                            <xsl:value-of select="generate-id(.)"/>
                                                                        </xsl:attribute>
                                                                        <xsl:if test="string(boolean($var_MaxLevelCode)) != 'false'">
                                                                            <attribute>
                                                                                <xsl:attribute name="id">MaxLevelCode</xsl:attribute>
                                                                                <text-val>
                                                                                    <xsl:value-of select="string($var_MaxLevelCode)"/>
                                                                                </text-val>
                                                                            </attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test="string(boolean($var_MinLevelCode)) != 'false'">
                                                                            <attribute>
                                                                                <xsl:attribute name="id">MinLevelCode</xsl:attribute>
                                                                                <text-val>
                                                                                    <xsl:value-of select="string($var_MinLevelCode)"/>
                                                                                </text-val>
                                                                            </attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test="string(boolean($var_SectorSubjectAreaCode)) != 'false'">
                                                                            <attribute>
                                                                                <xsl:attribute name="id">SectorSubjectAreaCode</xsl:attribute>
                                                                                <number-val>
                                                                                    <xsl:value-of select="string($var_SectorSubjectAreaCode)"/>
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
                                                    <xsl:attribute name="id">ONSPostcode</xsl:attribute>
                                                    <xsl:attribute name="complete">
                                                        <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                    </xsl:attribute>
                                                    <xsl:for-each select="ONSPostcode">
                                                        <xsl:variable name="var_Doterm"
                                                                      select="@Doterm"/>
                                                        <xsl:variable name="var_EffectiveFrom"
                                                                      select="@EffectiveFrom"/>
                                                        <xsl:variable name="var_EffectiveTo"
                                                                      select="@EffectiveTo"/>
                                                        <xsl:variable name="var_LEP1"
                                                                      select="@LEP1"/>
                                                        <xsl:variable name="var_LEP2"
                                                                      select="@LEP2"/>
                                                        <xsl:variable name="var_OSLAUA"
                                                                      select="@OSLAUA"/>
                                                        <instance>
                                                            <xsl:attribute name="id">
                                                                <xsl:value-of select="generate-id(.)"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string(boolean($var_Doterm)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">Doterm</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_Doterm)"/>
                                                                    </text-val>
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
                                                            <xsl:if test="string(boolean($var_LEP1)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LEP1</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_LEP1)"/>
                                                                    </text-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_LEP2)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">LEP2</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_LEP2)"/>
                                                                    </text-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_OSLAUA)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">OSLAUA</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_OSLAUA)"/>
                                                                    </text-val>
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
                                            <xsl:variable name="var_EmpIdLookup"
                                                          select="@EmpIdLookup"/>
                                            <xsl:variable name="var_EmpStat"
                                                          select="@EmpStat"/>
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
                                                <xsl:if test="string(boolean($var_EmpIdLookup)) != 'false'">
                                                    <attribute>
                                                        <xsl:attribute name="id">EmpIdLookup</xsl:attribute>
                                                        <boolean-val>
                                                            <xsl:value-of select="string($var_EmpIdLookup)"/>
                                                        </boolean-val>
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
                                                <entity>
                                                    <xsl:attribute name="id">
                                                        <xsl:value-of select="generate-id(.)"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="id">EmploymentStatusMonitoring</xsl:attribute>
                                                    <xsl:attribute name="complete">
                                                        <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                                                    </xsl:attribute>
                                                    <xsl:for-each select="EmploymentStatusMonitoring">
                                                        <xsl:variable name="var_ESMCode"
                                                                      select="@ESMCode"/>
                                                        <xsl:variable name="var_ESMType"
                                                                      select="@ESMType"/>
                                                        <instance>
                                                            <xsl:attribute name="id">
                                                                <xsl:value-of select="generate-id(.)"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string(boolean($var_ESMCode)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">ESMCode</xsl:attribute>
                                                                    <number-val>
                                                                        <xsl:value-of select="string($var_ESMCode)"/>
                                                                    </number-val>
                                                                </attribute>
                                                            </xsl:if>
                                                            <xsl:if test="string(boolean($var_ESMType)) != 'false'">
                                                                <attribute>
                                                                    <xsl:attribute name="id">ESMType</xsl:attribute>
                                                                    <text-val>
                                                                        <xsl:value-of select="string($var_ESMType)"/>
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
