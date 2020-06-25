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
          <instance>
            <xsl:attribute name="id">
              <xsl:value-of select="generate-id(.)"/>
            </xsl:attribute>
            <xsl:if test="string(boolean($var_UKPRN)) != 'false'">
              <attribute>
                <xsl:attribute name="id">UKPRN</xsl:attribute>
                <text-val>
                  <xsl:value-of select="string($var_UKPRN)"/>
                </text-val>
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
            <entity>
              <xsl:attribute name="id">
                <xsl:value-of select="generate-id(.)"/>
              </xsl:attribute>
              <xsl:attribute name="id">OrgFunding</xsl:attribute>
              <xsl:attribute name="complete">
                <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
              </xsl:attribute>
              <xsl:for-each select="OrgFunding">
                <xsl:variable name="var_OrgFundEffectiveFrom"
                              select="@OrgFundEffectiveFrom"/>
                <xsl:variable name="var_OrgFundEffectiveTo"
                              select="@OrgFundEffectiveTo"/>
                <xsl:variable name="var_OrgFundFactor"
                              select="@OrgFundFactor"/>
                <xsl:variable name="var_OrgFundFactType"
                              select="@OrgFundFactType"/>
                <xsl:variable name="var_OrgFundFactValue"
                              select="@OrgFundFactValue"/>
                <instance>
                  <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                  </xsl:attribute>
                  <xsl:if test="string(boolean($var_OrgFundEffectiveFrom)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">OrgFundEffectiveFrom</xsl:attribute>
                      <date-val>
                        <xsl:value-of select="string($var_OrgFundEffectiveFrom)"/>
                      </date-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_OrgFundEffectiveTo)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">OrgFundEffectiveTo</xsl:attribute>
                      <date-val>
                        <xsl:value-of select="string($var_OrgFundEffectiveTo)"/>
                      </date-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_OrgFundFactor)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">OrgFundFactor</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="string($var_OrgFundFactor)"/>
                      </text-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_OrgFundFactType)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">OrgFundFactType</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="string($var_OrgFundFactType)"/>
                      </text-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_OrgFundFactValue)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">OrgFundFactValue</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="string($var_OrgFundFactValue)"/>
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
              <xsl:attribute name="id">Learner</xsl:attribute>
              <xsl:attribute name="complete">
                <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
              </xsl:attribute>
              <xsl:for-each select="Learner">
                <xsl:variable name="var_LearnRefNumber"
                              select="@LearnRefNumber"/>
                <xsl:variable name="var_DateOfBirth"
                              select="@DateOfBirth"/>
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
                  <xsl:if test="string(boolean($var_DateOfBirth)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">DateOfBirth</xsl:attribute>
                      <date-val>
                        <xsl:value-of select="string($var_DateOfBirth)"/>
                      </date-val>
                    </attribute>
                  </xsl:if>
                  <entity>
                    <xsl:attribute name="id">
                      <xsl:value-of select="generate-id(.)"/>
                    </xsl:attribute>
                    <xsl:attribute name="id">SFA_PostcodeDisadvantage</xsl:attribute>
                    <xsl:attribute name="complete">
                      <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                    </xsl:attribute>
                    <xsl:for-each select="SFA_PostcodeDisadvantage">
                      <xsl:variable name="var_DisUpEffectiveFrom"
                                    select="@DisUpEffectiveFrom"/>
                      <xsl:variable name="var_DisUpEffectiveTo"
                                    select="@DisUpEffectiveTo"/>
                      <xsl:variable name="var_DisUplift"
                                    select="@DisUplift"/>
                      <instance>
                        <xsl:attribute name="id">
                          <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_DisUpEffectiveFrom)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">DisUpEffectiveFrom</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_DisUpEffectiveFrom)"/>
                            </date-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_DisUpEffectiveTo)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">DisUpEffectiveTo</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_DisUpEffectiveTo)"/>
                            </date-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_DisUplift)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">DisUplift</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_DisUplift)"/>
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
                    <xsl:attribute name="id">Camps_Identifiers_Reference_DataFunding</xsl:attribute>
                    <xsl:attribute name="complete">
                      <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                    </xsl:attribute>
                    <xsl:for-each select="Camps_Identifiers_Reference_DataFunding">
                      <xsl:variable name="var_EffectiveFrom"
                                    select="@EffectiveFrom"/>
                      <xsl:variable name="var_EffectiveTo"
                                    select="@EffectiveTo"/>
                      <xsl:variable name="var_SpecialistResources"
                                    select="@SpecialistResources"/>
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
                        <xsl:if test="string(boolean($var_SpecialistResources)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">SpecialistResources</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_SpecialistResources)"/>
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
                    <xsl:attribute name="id">LearnerEmploymentStatus</xsl:attribute>
                    <xsl:attribute name="complete">
                      <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                    </xsl:attribute>
                    <xsl:for-each select="LearnerEmploymentStatus">
                      <xsl:variable name="var_EmpId"
                                    select="@EmpId"/>
                      <xsl:variable name="var_DateEmpStatApp"
                                    select="@DateEmpStatApp"/>
                      <instance>
                        <xsl:attribute name="id">
                          <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_EmpId)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">EmpId</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_EmpId)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_DateEmpStatApp)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">DateEmpStatApp</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_DateEmpStatApp)"/>
                            </date-val>
                          </attribute>
                        </xsl:if>
                        <entity>
                          <xsl:attribute name="id">
                            <xsl:value-of select="generate-id(.)"/>
                          </xsl:attribute>
                          <xsl:attribute name="id">LargeEmployerReferenceData</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="LargeEmployerReferenceData">
                            <xsl:variable name="var_LargeEmpEffectiveFrom"
                                          select="@LargeEmpEffectiveFrom"/>
                            <xsl:variable name="var_LargeEmpEffectiveTo"
                                          select="@LargeEmpEffectiveTo"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_LargeEmpEffectiveFrom)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LargeEmpEffectiveFrom</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_LargeEmpEffectiveFrom)"/>
                                  </date-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_LargeEmpEffectiveTo)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LargeEmpEffectiveTo</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_LargeEmpEffectiveTo)"/>
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
                    <xsl:attribute name="id">LearningDelivery</xsl:attribute>
                    <xsl:attribute name="complete">
                      <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                    </xsl:attribute>
                    <xsl:for-each select="LearningDelivery">
                      <xsl:variable name="var_AimSeqNumber"
                                    select="@AimSeqNumber"/>
                      <xsl:variable name="var_AimType"
                                    select="@AimType"/>
                      <xsl:variable name="var_ProgType"
                                    select="@ProgType"/>
                      <xsl:variable name="var_LearnStartDate"
                                    select="@LearnStartDate"/>
                      <xsl:variable name="var_OrigLearnStartDate"
                                    select="@OrigLearnStartDate"/>
                      <xsl:variable name="var_LearnPlanEndDate"
                                    select="@LearnPlanEndDate"/>
                      <xsl:variable name="var_LearnActEndDate"
                                    select="@LearnActEndDate"/>
                      <xsl:variable name="var_AchDate"
                                    select="@AchDate"/>
                      <xsl:variable name="var_AddHours"
                                    select="@AddHours"/>
                      <xsl:variable name="var_CompStatus"
                                    select="@CompStatus"/>
                      <xsl:variable name="var_Outcome"
                                    select="@Outcome"/>
                      <xsl:variable name="var_EmpOutcome"
                                    select="@EmpOutcome"/>
                      <xsl:variable name="var_EnglPrscID"
                                    select="@EnglPrscID"/>
                      <xsl:variable name="var_EnglandFEHEStatus"
                                    select="@EnglandFEHEStatus"/>
                      <xsl:variable name="var_FundModel"
                                    select="@FundModel" />
                      <xsl:variable name="var_DelLocPostCode"
                                    select="@DelLocPostCode"/>
                      <xsl:variable name="var_FworkCode"
                                    select="@FworkCode"/>
                      <xsl:variable name="var_FrameworkCommonComponent"
                                    select="@FrameworkCommonComponent"/>
                      <xsl:variable name="var_FrameworkComponentType"
                                    select="@FrameworkComponentType"/>
                      <xsl:variable name="var_PwayCode"
                                    select="@PwayCode"/>
                      <xsl:variable name="var_PriorLearnFundAdj"
                                    select="@PriorLearnFundAdj"/>
                      <xsl:variable name="var_OtherFundAdj"
                                    select="@OtherFundAdj"/>
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
                        <xsl:if test="string(boolean($var_OrigLearnStartDate)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">OrigLearnStartDate</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_OrigLearnStartDate)"/>
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
                        <xsl:if test="string(boolean($var_EmpOutcome)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">EmpOutcome</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_EmpOutcome)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_EnglPrscID)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">EnglPrscID</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_EnglPrscID)"/>
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
                        <xsl:if test="string(boolean($var_FundModel)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">FundModel</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_FundModel)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_DelLocPostCode)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">DelLocPostCode</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_DelLocPostCode)"/>
                            </text-val>
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
                        <xsl:if test="string(boolean($var_FrameworkCommonComponent)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">FrameworkCommonComponent</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_FrameworkCommonComponent)"/>
                            </number-val>
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
                        <xsl:if test="string(boolean($var_PwayCode)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">PwayCode</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_PwayCode)"/>
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
                            <xsl:variable name="var_LearnDelFAMType"
                                          select="@LearnDelFAMType"/>
                            <xsl:variable name="var_LearnDelFAMCode"
                                          select="@LearnDelFAMCode"/>
                            <xsl:variable name="var_LearnDelFAMDateFrom"
                                          select="@LearnDelFAMDateFrom"/>
                            <xsl:variable name="var_LearnDelFAMDateTo"
                                          select="@LearnDelFAMDateTo"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_LearnDelFAMType)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LearnDelFAMType</xsl:attribute>
                                  <text-val>
                                    <xsl:value-of select="string($var_LearnDelFAMType)"/>
                                  </text-val>
                                </attribute>
                              </xsl:if>
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
                            </instance>
                          </xsl:for-each>
                        </entity>
                        <entity>
                          <xsl:attribute name="id">
                            <xsl:value-of select="generate-id(.)"/>
                          </xsl:attribute>
                          <xsl:attribute name="id">LearningDeliveryLARSCategory</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="LearningDeliveryLARSCategory">
                            <xsl:variable name="var_LearnDelCatRef"
                                          select="@LearnDelCatRef"/>
                            <xsl:variable name="var_LearnDelCatDateFrom"
                                          select="@LearnDelCatDateFrom"/>
                            <xsl:variable name="var_LearnDelCatDateTo"
                                          select="@LearnDelCatDateTo"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_LearnDelCatRef)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LearnDelCatRef</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_LearnDelCatRef)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_LearnDelCatDateFrom)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LearnDelCatDateFrom</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_LearnDelCatDateFrom)"/>
                                  </date-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_LearnDelCatDateTo)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LearnDelCatDateTo</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_LearnDelCatDateTo)"/>
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
                            <xsl:variable name="var_LARSFundUnweightedRate"
                                          select="@LARSFundUnweightedRate"/>
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
                              <xsl:if test="string(boolean($var_LARSFundUnweightedRate)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LARSFundUnweightedRate</xsl:attribute>
                                  <currency-val>
                                    <xsl:value-of select="string($var_LARSFundUnweightedRate)"/>
                                  </currency-val>
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
                </instance>
              </xsl:for-each>
            </entity>
            <entity>
              <xsl:attribute name="id">
                <xsl:value-of select="generate-id(.)"/>
              </xsl:attribute>
              <xsl:attribute name="id">Postcode_Specialist_Resource_RefData</xsl:attribute>
              <xsl:attribute name="complete">
                <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
              </xsl:attribute>
              <xsl:for-each select="Postcode_Specialist_Resource_RefData">
                <xsl:variable name="var_PostcodeSpecResEffectiveFrom"
                              select="@PostcodeSpecResEffectiveFrom"/>
                <xsl:variable name="var_PostcodeSpecResEffectiveTo"
                              select="@PostcodeSpecResEffectiveTo"/>
                <xsl:variable name="var_PostcodeSpecResPostcode"
                              select="@PostcodeSpecResPostcode"/>
                <xsl:variable name="var_PostcodeSpecResSpecialistResources"
                              select="@PostcodeSpecResSpecialistResources"/>
                <instance>
                  <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                  </xsl:attribute>
                  <xsl:if test="string(boolean($var_PostcodeSpecResEffectiveFrom)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">PostcodeSpecResEffectiveFrom</xsl:attribute>
                      <date-val>
                        <xsl:value-of select="string($var_PostcodeSpecResEffectiveFrom)"/>
                      </date-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_PostcodeSpecResEffectiveTo)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">PostcodeSpecResEffectiveTo</xsl:attribute>
                      <date-val>
                        <xsl:value-of select="string($var_PostcodeSpecResEffectiveTo)"/>
                      </date-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_PostcodeSpecResPostcode)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">PostcodeSpecResPostcode</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="string($var_PostcodeSpecResPostcode)"/>
                      </text-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_PostcodeSpecResSpecialistResources)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">PostcodeSpecResSpecialistResources</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="string($var_PostcodeSpecResSpecialistResources)"/>
                      </text-val>
                    </attribute>
                  </xsl:if>
                </instance>
              </xsl:for-each>
            </entity>
          </instance>
        </xsl:for-each>
      </entity>
    </session-data>
  </xsl:template>
</xsl:stylesheet>
