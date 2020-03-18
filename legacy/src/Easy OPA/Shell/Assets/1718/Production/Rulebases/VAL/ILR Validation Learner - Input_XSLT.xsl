<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <session-data>
      <xsl:attribute name="xsi:noNamespaceSchemaLocation" namespace="http://www.w3.org/2001/XMLSchema-instance">C:/PROGRA~2/Oracle/POLICY~1/bin/sessiondata.xsd</xsl:attribute>
      <entity>
        <xsl:attribute name="id">
          <xsl:value-of select="generate-id(.)"/>
        </xsl:attribute>
        <xsl:attribute name="id">global</xsl:attribute>
        <xsl:attribute name="complete">
          <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
        </xsl:attribute>
        <xsl:for-each select="global">
          <xsl:variable name="var_DesktopMode" select="@DesktopMode"/>
          <xsl:variable name="var_EmployerVersion" select="@EmployerVersion"/>
          <xsl:variable name="var_FCT_16-18APPS1718" select="@FCT_16-18APPS1718"/>
          <xsl:variable name="var_FCT_16-18NLA1718" select="@FCT_16-18NLA1718"/>
          <xsl:variable name="var_FCT_1618NLA1718" select="@FCT_1618NLA1718"/>
          <xsl:variable name="var_FCT_AAPP1718" select="@FCT_AAPP1718"/>
          <xsl:variable name="var_FCT_AEBC1718" select="@FCT_AEBC1718"/>
          <xsl:variable name="var_FCT_AEBTO-TOL1718" select="@FCT_AEBTO-TOL1718"/>
          <xsl:variable name="var_FCT_ALLB1718" select="@FCT_ALLB1718"/>
          <xsl:variable name="var_FCT_ALLBC1718" select="@FCT_ALLBC1718"/>
          <xsl:variable name="var_FCT_ANLA1718" select="@FCT_ANLA1718"/>
          <xsl:variable name="var_FCT_ESF1420" select="@FCT_ESF1420"/>
          <xsl:variable name="var_FCT_LEVY1799" select="@FCT_LEVY1799"/>
          <xsl:variable name="var_FCT_AEB-CL1718" select="@FCT_AEB-CL1718"/>
          <xsl:variable name="var_FCT_AEB-LS1718" select="@FCT_AEB-LS1718"/>
          <xsl:variable name="var_FCT_AEB-TOL1718" select="@FCT_AEB-TOL1718"/>
          <xsl:variable name="var_FCT_ANLAP2018" select="@FCT_ANLAP2018"/>
          <xsl:variable name="var_FCT_16-18NLAP2018" select="@FCT_16-18NLAP2018"/>
          <xsl:variable name="var_FilePreparationDate" select="@FilePreparationDate"/>
          <xsl:variable name="var_LARSVersion" select="@LARSVersion"/>
          <xsl:variable name="var_LegalOrgType" select="@LegalOrgType"/>
          <xsl:variable name="var_OrgVersion" select="@OrgVersion"/>
          <xsl:variable name="var_PostcodeVersion" select="@PostcodeVersion"/>
          <xsl:variable name="var_UKPRN" select="@UKPRN"/>
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
            <xsl:if test="string(boolean($var_EmployerVersion)) != 'false'">
              <attribute>
                <xsl:attribute name="id">EmployerVersion</xsl:attribute>
                <text-val>
                  <xsl:value-of select="string($var_EmployerVersion)"/>
                </text-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_16-18APPS1718)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_16-18APPS1718</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_16-18APPS1718)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_16-18NLA1718)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_16-18NLA1718</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_16-18NLA1718)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_1618NLA1718)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_1618NLA1718</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_1618NLA1718)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_AAPP1718)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_AAPP1718</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_AAPP1718)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_AEBC1718)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_AEBC1718</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_AEBC1718)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_AEBTO-TOL1718)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_AEBTO-TOL1718</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_AEBTO-TOL1718)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_ALLB1718)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_ALLB1718</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_ALLB1718)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_ALLBC1718)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_ALLBC1718</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_ALLBC1718)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_ANLA1718)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_ANLA1718</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_ANLA1718)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_ESF1420)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_ESF1420</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_ESF1420)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_LEVY1799)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_LEVY1799</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_LEVY1799)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_AEB-CL1718)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_AEB-CL1718</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_AEB-CL1718)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_AEB-LS1718)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_AEB-LS1718</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_AEB-LS1718)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_AEB-TOL1718)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_AEB-TOL1718</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_AEB-TOL1718)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_ANLAP2018)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_ANLAP2018</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_ANLAP2018)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FCT_16-18NLAP2018)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FCT_16-18NLAP2018</xsl:attribute>
                <boolean-val>
                  <xsl:value-of select="string($var_FCT_16-18NLAP2018)"/>
                </boolean-val>
              </attribute>
            </xsl:if>
            <xsl:if test="string(boolean($var_FilePreparationDate)) != 'false'">
              <attribute>
                <xsl:attribute name="id">FilePreparationDate</xsl:attribute>
                <date-val>
                  <xsl:value-of select="string($var_FilePreparationDate)"/>
                </date-val>
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
            <xsl:if test="string(boolean($var_LegalOrgType)) != 'false'">
              <attribute>
                <xsl:attribute name="id">LegalOrgType</xsl:attribute>
                <text-val>
                  <xsl:value-of select="string($var_LegalOrgType)"/>
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
            <xsl:if test="string(boolean($var_PostcodeVersion)) != 'false'">
              <attribute>
                <xsl:attribute name="id">PostcodeVersion</xsl:attribute>
                <text-val>
                  <xsl:value-of select="string($var_PostcodeVersion)"/>
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
                <xsl:variable name="var_Accom" select="@Accom"/>
                <xsl:variable name="var_AddLine1" select="@AddLine1"/>
                <xsl:variable name="var_AddLine2" select="@AddLine2"/>
                <xsl:variable name="var_AddLine3" select="@AddLine3"/>
                <xsl:variable name="var_ALSCost" select="@ALSCost"/>
                <xsl:variable name="var_DateOfBirth" select="@DateOfBirth"/>
                <xsl:variable name="var_Email" select="@Email"/>
                <xsl:variable name="var_EngGrade" select="@EngGrade"/>
                <xsl:variable name="var_Ethnicity" select="@Ethnicity"/>
                <xsl:variable name="var_FamilyName" select="@FamilyName"/>
                <xsl:variable name="var_GivenNames" select="@GivenNames"/>
                <xsl:variable name="var_LearnRefNumber" select="@LearnRefNumber"/>
                <xsl:variable name="var_LLDDHealthProb" select="@LLDDHealthProb"/>
                <xsl:variable name="var_MathGrade" select="@MathGrade"/>
                <xsl:variable name="var_NINumber" select="@NINumber"/>
                <xsl:variable name="var_PlanEEPHours" select="@PlanEEPHours"/>
                <xsl:variable name="var_PlanLearnHours" select="@PlanLearnHours"/>
                <xsl:variable name="var_PMUKPRN" select="@PMUKPRN"/>
                <xsl:variable name="var_PMUKPRNLookUp" select="@PMUKPRNLookUp"/>
                <xsl:variable name="var_Postcode" select="@Postcode"/>
                <xsl:variable name="var_PostcodeLookUp" select="@PostcodeLookUp"/>
                <xsl:variable name="var_PostcodePrior" select="@PostcodePrior"/>
                <xsl:variable name="var_PostCodePriorLookup" select="@PostCodePriorLookup"/>
                <xsl:variable name="var_PrevUKPRN" select="@PrevUKPRN"/>
                <xsl:variable name="var_PrevUKPRNLookup" select="@PrevUKPRNLookup"/>
                <xsl:variable name="var_PriorAttain" select="@PriorAttain"/>
                <xsl:variable name="var_Sex" select="@Sex"/>
                <xsl:variable name="var_TelNo" select="@TelNo"/>
                <xsl:variable name="var_ULN" select="@ULN"/>
                <xsl:variable name="var_ULNLookup" select="@ULNLookup"/>
                <instance>
                  <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(.)"/>
                  </xsl:attribute>
                  <xsl:if test="string(boolean($var_Accom)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">Accom</xsl:attribute>
                      <number-val>
                        <xsl:value-of select="string($var_Accom)"/>
                      </number-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_AddLine1)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">AddLine1</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="$var_AddLine1"/>
                      </text-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_AddLine2)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">AddLine2</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="$var_AddLine2"/>
                      </text-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_AddLine3)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">AddLine3</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="$var_AddLine3"/>
                      </text-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_ALSCost)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">ALSCost</xsl:attribute>
                      <number-val>
                        <xsl:value-of select="string($var_ALSCost)"/>
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
                  <xsl:if test="string(boolean($var_Email)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">Email</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="$var_Email"/>
                      </text-val>
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
                  <xsl:if test="string(boolean($var_Ethnicity)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">Ethnicity</xsl:attribute>
                      <number-val>
                        <xsl:value-of select="string($var_Ethnicity)"/>
                      </number-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_FamilyName)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">FamilyName</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="string($var_FamilyName)"/>
                      </text-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_GivenNames)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">GivenNames</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="string($var_GivenNames)"/>
                      </text-val>
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
                  <xsl:if test="string(boolean($var_MathGrade)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">MathGrade</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="string($var_MathGrade)"/>
                      </text-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_NINumber)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">NINumber</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="string($var_NINumber)"/>
                      </text-val>
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
                  <xsl:if test="string(boolean($var_PMUKPRN)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">PMUKPRN</xsl:attribute>
                      <number-val>
                        <xsl:value-of select="$var_PMUKPRN"/>
                      </number-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_PMUKPRNLookUp)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">PMUKPRNLookUp</xsl:attribute>
                      <boolean-val>
                        <xsl:value-of select="$var_PMUKPRNLookUp"/>
                      </boolean-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_Postcode)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">Postcode</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="$var_Postcode"/>
                      </text-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_PostcodeLookUp)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">PostcodeLookUp</xsl:attribute>
                      <boolean-val>
                        <xsl:value-of select="$var_PostcodeLookUp"/>
                      </boolean-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_PostcodePrior)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">PostcodePrior</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="$var_PostcodePrior"/>
                      </text-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_PostCodePriorLookup)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">PostCodePriorLookup</xsl:attribute>
                      <boolean-val>
                        <xsl:value-of select="string($var_PostCodePriorLookup)"/>
                      </boolean-val>
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
                  <xsl:if test="string(boolean($var_PrevUKPRNLookup)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">PrevUKPRNLookup</xsl:attribute>
                      <boolean-val>
                        <xsl:value-of select="string($var_PrevUKPRNLookup)"/>
                      </boolean-val>
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
                  <xsl:if test="string(boolean($var_Sex)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">Sex</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="string($var_Sex)"/>
                      </text-val>
                    </attribute>
                  </xsl:if>
                  <xsl:if test="string(boolean($var_TelNo)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">TelNo</xsl:attribute>
                      <text-val>
                        <xsl:value-of select="$var_TelNo"/>
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
                  <xsl:if test="string(boolean($var_ULNLookup)) != 'false'">
                    <attribute>
                      <xsl:attribute name="id">ULNLookup</xsl:attribute>
                      <boolean-val>
                        <xsl:value-of select="string($var_ULNLookup)"/>
                      </boolean-val>
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
                      <xsl:variable name="var_AchDate" select="@AchDate"/>
                      <xsl:variable name="var_AddHours" select="@AddHours"/>
                      <xsl:variable name="var_AimSeqNumber" select="@AimSeqNumber"/>
                      <xsl:variable name="var_AimType" select="@AimType"/>
                      <xsl:variable name="var_AwardOrgAimRef" select="@AwardOrgAimRef"/>
                      <xsl:variable name="var_CompStatus" select="@CompStatus"/>
                      <xsl:variable name="var_ConRefNumber" select="@ConRefNumber"/>
                      <xsl:variable name="var_ConRefNumberValidLookUP" select="@ConRefNumberValidLookUP"/>
                      <xsl:variable name="var_DelLocPostcode" select="@DelLocPostcode"/>
                      <xsl:variable name="var_DelLocPostcodeLookup" select="@DelLocPostcodeLookup"/>
                      <xsl:variable name="var_DelLocPostcodeOLASSLookup" select="@DelLocPostcodeOLASSLookup"/>
                      <xsl:variable name="var_EmpOutcome" select="@EmpOutcome"/>
                      <xsl:variable name="var_EPAOrgId" select="@EPAOrgId"/>
                      <xsl:variable name="var_EPAIDLookup" select="@EPAIDLookup"/>
                      <xsl:variable name="var_FrameworkAimEffectiveTo" select="@FrameworkAimEffectiveTo"/>
                      <xsl:variable name="var_FrameworkAimLookup" select="@FrameworkAimLookup"/>
                      <xsl:variable name="var_FrameworkCommonComponent" select="@FrameworkCommonComponent"/>
                      <xsl:variable name="var_FrameworkCommonLookup" select="@FrameworkCommonLookup"/>
                      <xsl:variable name="var_FrameworkComponentType" select="@FrameworkComponentType"/>
                      <xsl:variable name="var_FrameworkEffectiveTo" select="@FrameworkEffectiveTo"/>
                      <xsl:variable name="var_FrameworkLookup" select="@FrameworkLookup"/>
                      <xsl:variable name="var_FrameworkPathwayEffectiveTo" select="@FrameworkPathwayEffectiveTo"/>
                      <xsl:variable name="var_FrameworkPathwayLookup" select="@FrameworkPathwayLookup"/>
                      <xsl:variable name="var_FundModel" select="@FundModel"/>
                      <xsl:variable name="var_FworkCode" select="@FworkCode"/>
                      <xsl:variable name="var_LARS_CategoryRef9" select="@LARS_CategoryRef9"/>
                      <xsl:variable name="var_LARS_EnglPrscID" select="@LARS_EnglPrscID"/>
                      <xsl:variable name="var_LARS_LearningDeliveryGenre" select="@LARS_LearningDeliveryGenre"/>
                      <xsl:variable name="var_LDCS1Code" select="@LDCS1Code"/>
                      <xsl:variable name="var_LDCS2Code" select="@LDCS2Code"/>
                      <xsl:variable name="var_LDCS3Code" select="@LDCS3Code"/>
                      <xsl:variable name="var_LearnActEndDate" select="@LearnActEndDate"/>
                      <xsl:variable name="var_LearnAimRef" select="@LearnAimRef"/>
                      <xsl:variable name="var_LearnAimRefLookup" select="@LearnAimRefLookup"/>
                      <xsl:variable name="var_LearnAimRefType" select="@LearnAimRefType"/>
                      <xsl:variable name="var_LearnPlanEndDate" select="@LearnPlanEndDate"/>
                      <xsl:variable name="var_LearnStartDate" select="@LearnStartDate"/>
                      <xsl:variable name="var_NotionalNVQLevelv2" select="@NotionalNVQLevelv2"/>
                      <xsl:variable name="var_OrigLearnStartDate" select="@OrigLearnStartDate"/>
                      <xsl:variable name="var_OtherFundAdj" select="@OtherFundAdj"/>
                      <xsl:variable name="var_Outcome" select="@Outcome"/>
                      <xsl:variable name="var_OutGrade" select="@OutGrade"/>
                      <xsl:variable name="var_PartnerUKPRN" select="@PartnerUKPRN"/>
                      <xsl:variable name="var_PartnerUKPRNLookup" select="@PartnerUKPRNLookup"/>
                      <xsl:variable name="var_PriorLearnFundAdj" select="@PriorLearnFundAdj"/>
                      <xsl:variable name="var_ProgType" select="@ProgType"/>
                      <xsl:variable name="var_PwayCode" select="@PwayCode"/>
                      <xsl:variable name="var_Section96ApprovalStatus" select="@Section96ApprovalStatus"/>
                      <xsl:variable name="var_Section96ReviewDate" select="@Section96ReviewDate"/>
                      <xsl:variable name="var_StandardCodeLookup" select="@StandardCodeLookup"/>
                      <xsl:variable name="var_StandardEffectiveTo" select="@StandardEffectiveTo"/>
                      <xsl:variable name="var_StdCode" select="@StdCode"/>
                      <xsl:variable name="var_SWSupAimId" select="@SWSupAimId"/>
                      <xsl:variable name="var_UnemployedOnly" select="@UnemployedOnly"/>
                      <xsl:variable name="var_UnitType" select="@UnitType"/>
                      <xsl:variable name="var_WithdrawReason" select="@WithdrawReason"/>
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
                        <xsl:if test="string(boolean($var_AimType)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">AimType</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_AimType)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_AwardOrgAimRef)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">AwardOrgAimRef</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_AwardOrgAimRef)"/>
                            </text-val>
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
                        <xsl:if test="string(boolean($var_ConRefNumberValidLookUP)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">ConRefNumberValidLookUP</xsl:attribute>
                            <boolean-val>
                              <xsl:value-of select="string($var_ConRefNumberValidLookUP)"/>
                            </boolean-val>
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
                        <xsl:if test="string(boolean($var_DelLocPostcodeLookup)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">DelLocPostcodeLookup</xsl:attribute>
                            <boolean-val>
                              <xsl:value-of select="string($var_DelLocPostcodeLookup)"/>
                            </boolean-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_DelLocPostcodeOLASSLookup)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">DelLocPostcodeOLASSLookup</xsl:attribute>
                            <boolean-val>
                              <xsl:value-of select="string($var_DelLocPostcodeOLASSLookup)"/>
                            </boolean-val>
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
                        <xsl:if test="string(boolean($var_EPAOrgId)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">EPAOrgID</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_EPAOrgId)"/>
                            </text-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_EPAIDLookup)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">EPAIDLookup</xsl:attribute>
                            <boolean-val>
                              <xsl:value-of select="string($var_EPAIDLookup)"/>
                            </boolean-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_FrameworkAimEffectiveTo)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">FrameworkAimEffectiveTo</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_FrameworkAimEffectiveTo)"/>
                            </date-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_FrameworkAimLookup)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">FrameworkAimLookup</xsl:attribute>
                            <boolean-val>
                              <xsl:value-of select="string($var_FrameworkAimLookup)"/>
                            </boolean-val>
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
                        <xsl:if test="string(boolean($var_FrameworkCommonLookup)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">FrameworkCommonLookup</xsl:attribute>
                            <boolean-val>
                              <xsl:value-of select="string($var_FrameworkCommonLookup)"/>
                            </boolean-val>
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
                        <xsl:if test="string(boolean($var_FrameworkEffectiveTo)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">FrameworkEffectiveTo</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_FrameworkEffectiveTo)"/>
                            </date-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_FrameworkLookup)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">FrameworkLookup</xsl:attribute>
                            <boolean-val>
                              <xsl:value-of select="string($var_FrameworkLookup)"/>
                            </boolean-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_FrameworkPathwayEffectiveTo)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">FrameworkPathwayEffectiveTo</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_FrameworkPathwayEffectiveTo)"/>
                            </date-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_FrameworkPathwayLookup)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">FrameworkPathwayLookup</xsl:attribute>
                            <boolean-val>
                              <xsl:value-of select="string($var_FrameworkPathwayLookup)"/>
                            </boolean-val>
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
                        <xsl:if test="string(boolean($var_LARS_CategoryRef9)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">LARS_CategoryRef9</xsl:attribute>
                            <boolean-val>
                              <xsl:value-of select="string($var_LARS_CategoryRef9)"/>
                            </boolean-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_LARS_EnglPrscID)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">LARS_EnglPrscID</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_LARS_EnglPrscID)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_LARS_LearningDeliveryGenre)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">LARS_LearningDeliveryGenre</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_LARS_LearningDeliveryGenre)"/>
                            </text-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_LDCS1Code)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">LDCS1Code</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_LDCS1Code)"/>
                            </text-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_LDCS2Code)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">LDCS2Code</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_LDCS2Code)"/>
                            </text-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_LDCS3Code)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">LDCS3Code</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_LDCS3Code)"/>
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
                        <xsl:if test="string(boolean($var_LearnAimRefLookup)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">LearnAimRefLookup</xsl:attribute>
                            <boolean-val>
                              <xsl:value-of select="string($var_LearnAimRefLookup)"/>
                            </boolean-val>
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
                        <xsl:if test="string(boolean($var_OutGrade)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">OutGrade</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_OutGrade)"/>
                            </text-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_PartnerUKPRN)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">PartnerUKPRN</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_PartnerUKPRN)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_PartnerUKPRNLookup)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">PartnerUKPRNLookup</xsl:attribute>
                            <boolean-val>
                              <xsl:value-of select="string($var_PartnerUKPRNLookup)"/>
                            </boolean-val>
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
                        <xsl:if test="string(boolean($var_PwayCode)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">PwayCode</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_PwayCode)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_Section96ApprovalStatus)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">Section96ApprovalStatus</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_Section96ApprovalStatus)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_Section96ReviewDate)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">Section96ReviewDate</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_Section96ReviewDate)"/>
                            </date-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_StandardCodeLookup)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">StandardCodeLookup</xsl:attribute>
                            <boolean-val>
                              <xsl:value-of select="string($var_StandardCodeLookup)"/>
                            </boolean-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_StandardEffectiveTo)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">StandardEffectiveTo</xsl:attribute>
                            <date-val>
                              <xsl:value-of select="string($var_StandardEffectiveTo)"/>
                            </date-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_StdCode)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">StdCode</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_StdCode)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_SWSupAimId)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">SWSupAimId</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_SWSupAimId)"/>
                            </text-val>
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
                        <xsl:if test="string(boolean($var_UnitType)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">UnitType</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_UnitType)"/>
                            </text-val>
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
                            <xsl:variable name="var_LearnDelFAMCode" select="@LearnDelFAMCode"/>
                            <xsl:variable name="var_LearnDelFAMDateFrom" select="@LearnDelFAMDateFrom"/>
                            <xsl:variable name="var_LearnDelFAMDateTo" select="@LearnDelFAMDateTo"/>
                            <xsl:variable name="var_LearnDelFAMType" select="@LearnDelFAMType"/>
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
                          <xsl:attribute name="id">LearningDeliveryHE</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="LearningDeliveryHE">
                            <xsl:variable name="var_DOMICILE" select="@DOMICILE"/>
                            <xsl:variable name="var_ELQ" select="@ELQ"/>
                            <xsl:variable name="var_FUNDCOMP" select="@FUNDCOMP"/>
                            <xsl:variable name="var_FUNDLEV" select="@FUNDLEV"/>
                            <xsl:variable name="var_GROSSFEE" select="@GROSSFEE"/>
                            <xsl:variable name="var_HEPostCode" select="@HEPostCode"/>
                            <xsl:variable name="var_HEPostCodeLookup" select="@HEPostCodeLookup"/>
                            <xsl:variable name="var_MODESTUD" select="@MODESTUD"/>
                            <xsl:variable name="var_MSTUFEE" select="@MSTUFEE"/>
                            <xsl:variable name="var_NETFEE" select="@NETFEE"/>
                            <xsl:variable name="var_NUMHUS" select="@NUMHUS"/>
                            <xsl:variable name="var_PCFLDCS" select="@PCFLDCS"/>
                            <xsl:variable name="var_PCOLAB" select="@PCOLAB"/>
                            <xsl:variable name="var_PCSLDCS" select="@PCSLDCS"/>
                            <xsl:variable name="var_PCTLDCS" select="@PCTLDCS"/>
                            <xsl:variable name="var_QUALENT3" select="@QUALENT3"/>
                            <xsl:variable name="var_SEC" select="@SEC"/>
                            <xsl:variable name="var_SOC2000" select="@SOC2000"/>
                            <xsl:variable name="var_SPECFEE" select="@SPECFEE"/>
                            <xsl:variable name="var_SSN" select="@SSN"/>
                            <xsl:variable name="var_STULOAD" select="@STULOAD"/>
                            <xsl:variable name="var_TYPEYR" select="@TYPEYR"/>
                            <xsl:variable name="var_UCASAPPID" select="@UCASAPPID"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_DOMICILE)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">DOMICILE</xsl:attribute>
                                  <text-val>
                                    <xsl:value-of select="string($var_DOMICILE)"/>
                                  </text-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_ELQ)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">ELQ</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_ELQ)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_FUNDCOMP)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">FUNDCOMP</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_FUNDCOMP)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_FUNDLEV)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">FUNDLEV</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_FUNDLEV)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_GROSSFEE)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">GROSSFEE</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_GROSSFEE)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_HEPostCode)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">HEPostCode</xsl:attribute>
                                  <text-val>
                                    <xsl:value-of select="string($var_HEPostCode)"/>
                                  </text-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_HEPostCodeLookup)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">HEPostCodeLookup</xsl:attribute>
                                  <boolean-val>
                                    <xsl:value-of select="string($var_HEPostCodeLookup)"/>
                                  </boolean-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_MODESTUD)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">MODESTUD</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_MODESTUD)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_MSTUFEE)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">MSTUFEE</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_MSTUFEE)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_NETFEE)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">NETFEE</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_NETFEE)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_NUMHUS)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">NUMHUS</xsl:attribute>
                                  <text-val>
                                    <xsl:value-of select="string($var_NUMHUS)"/>
                                  </text-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_PCFLDCS)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">PCFLDCS</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_PCFLDCS)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_PCOLAB)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">PCOLAB</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_PCOLAB)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_PCSLDCS)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">PCSLDCS</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_PCSLDCS)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_PCTLDCS)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">PCTLDCS</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_PCTLDCS)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_QUALENT3)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">QUALENT3</xsl:attribute>
                                  <text-val>
                                    <xsl:value-of select="string($var_QUALENT3)"/>
                                  </text-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_SEC)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">SEC</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_SEC)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_SOC2000)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">SOC2000</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_SOC2000)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_SPECFEE)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">SPECFEE</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_SPECFEE)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_SSN)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">SSN</xsl:attribute>
                                  <text-val>
                                    <xsl:value-of select="string($var_SSN)"/>
                                  </text-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_STULOAD)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">STULOAD</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_STULOAD)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_TYPEYR)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">TYPEYR</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_TYPEYR)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_UCASAPPID)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">UCASAPPID</xsl:attribute>
                                  <text-val>
                                    <xsl:value-of select="string($var_UCASAPPID)"/>
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
                          <xsl:attribute name="id">ProviderSpecDeliveryMonitoring</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="ProviderSpecDeliveryMonitoring">
                            <xsl:variable name="var_ProvSpecDelMon" select="@ProvSpecDelMon"/>
                            <xsl:variable name="var_ProvSpecDelMonOccur" select="@ProvSpecDelMonOccur"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_ProvSpecDelMon)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">ProvSpecDelMon</xsl:attribute>
                                  <text-val>
                                    <xsl:value-of select="string($var_ProvSpecDelMon)"/>
                                  </text-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_ProvSpecDelMonOccur)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">ProvSpecDelMonOccur</xsl:attribute>
                                  <text-val>
                                    <xsl:value-of select="string($var_ProvSpecDelMonOccur)"/>
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
                          <xsl:attribute name="id">LearningDeliveryLARSStandardFunding</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true')) = ('true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="LearningDeliveryLARSStandardFunding">
                            <xsl:variable name="var_CoreGovContributionCap" select="@CoreGovContributionCap"/>
                            <xsl:variable name="var_LARSFundEffectiveFrom" select="@LARSFundEffectiveFrom"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_CoreGovContributionCap)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">CoreGovContributionCap</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="$var_CoreGovContributionCap"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_LARSFundEffectiveFrom)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LARSFundEffectiveFrom</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="$var_LARSFundEffectiveFrom"/>
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
                            <xsl:variable name="var_ValidityCategory" select="@ValidityCategory"/>
                            <xsl:variable name="var_ValidityEndDate" select="@ValidityEndDate"/>
                            <xsl:variable name="var_ValidityLastNewStartDate" select="@ValidityLastNewStartDate"/>
                            <xsl:variable name="var_ValidityStartDate" select="@ValidityStartDate"/>
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
                          <xsl:attribute name="id">LearningDeliveryWorkPlacement</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="LearningDeliveryWorkPlacement">
                            <xsl:variable name="var_WorkPlaceEmpId" select="@WorkPlaceEmpId"/>
                            <xsl:variable name="var_WorkPlaceEmpIdLookup" select="@WorkPlaceEmpIdLookup"/>
                            <xsl:variable name="var_WorkPlaceEndDate" select="@WorkPlaceEndDate"/>
                            <xsl:variable name="var_WorkPlaceMode" select="@WorkPlaceMode"/>
                            <xsl:variable name="var_WorkPlaceStartDate" select="@WorkPlaceStartDate"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_WorkPlaceEmpId)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">WorkPlaceEmpId</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_WorkPlaceEmpId)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_WorkPlaceEmpIdLookup)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">WorkPlaceEmpIdLookup</xsl:attribute>
                                  <boolean-val>
                                    <xsl:value-of select="string($var_WorkPlaceEmpIdLookup)"/>
                                  </boolean-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_WorkPlaceEndDate)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">WorkPlaceEndDate</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_WorkPlaceEndDate)"/>
                                  </date-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_WorkPlaceMode)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">WorkPlaceMode</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_WorkPlaceMode)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_WorkPlaceStartDate)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">WorkPlaceStartDate</xsl:attribute>
                                  <date-val>
                                    <xsl:value-of select="string($var_WorkPlaceStartDate)"/>
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
                          <xsl:attribute name="id">ApprenticeshipFinancialRecord</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="ApprenticeshipFinancialRecord">
                            <xsl:variable name="var_AFinAmount" select="@AFinAmount"/>
                            <xsl:variable name="var_AFinCode" select="@AFinCode"/>
                            <xsl:variable name="var_AFinDate" select="@AFinDate"/>
                            <xsl:variable name="var_AFinType" select="@AFinType"/>
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
                          <xsl:attribute name="id">LearningDeliveryAnnualValue</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="LearningDeliveryAnnualValue">
                            <xsl:variable name="var_BasicSkills" select="@BasicSkills"/>
                            <xsl:variable name="var_FullLevel2EntitlementCategory" select="@FullLevel2EntitlementCategory"/>
                            <xsl:variable name="var_FullLevel2Percent" select="@FullLevel2Percent"/>
                            <xsl:variable name="var_FullLevel3EntitlementCategory" select="@FullLevel3EntitlementCategory"/>
                            <xsl:variable name="var_FullLevel3Percent" select="@FullLevel3Percent"/>
                            <xsl:variable name="var_LearnDelAnnValBasicSkillsTypeCode" select="@LearnDelAnnValBasicSkillsTypeCode"/>
                            <xsl:variable name="var_LearnDelAnnValDateFrom" select="@LearnDelAnnValDateFrom"/>
                            <xsl:variable name="var_LearnDelAnnValDateTo" select="@LearnDelAnnValDateTo"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_BasicSkills)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">BasicSkills</xsl:attribute>
                                  <boolean-val>
                                    <xsl:value-of select="string($var_BasicSkills)"/>
                                  </boolean-val>
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
                          <xsl:attribute name="id">LearningDeliveryLARSCategory</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="LearningDeliveryLARSCategory">
                            <xsl:variable name="var_LARSCategoryRef" select="@LARSCategoryRef"/>
                            <xsl:variable name="var_ParentLARSCategoryRef" select="@ParentLARSCategoryRef"/>
                            <xsl:variable name="var_TopLevelLARSCategoryRef" select="@TopLevelLARSCategoryRef"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_LARSCategoryRef)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">LARSCategoryRef</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_LARSCategoryRef)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_ParentLARSCategoryRef)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">ParentLARSCategoryRef</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_ParentLARSCategoryRef)"/>
                                  </number-val>
                                </attribute>
                              </xsl:if>
                              <xsl:if test="string(boolean($var_TopLevelLARSCategoryRef)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">TopLevelLARSCategoryRef</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_TopLevelLARSCategoryRef)"/>
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
                    <xsl:attribute name="id">LearnerFAM</xsl:attribute>
                    <xsl:attribute name="complete">
                      <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                    </xsl:attribute>
                    <xsl:for-each select="LearnerFAM">
                      <xsl:variable name="var_LearnFAMCode" select="@LearnFAMCode"/>
                      <xsl:variable name="var_LearnFAMType" select="@LearnFAMType"/>
                      <instance>
                        <xsl:attribute name="id">
                          <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_LearnFAMCode)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">LearnFAMCode</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_LearnFAMCode)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_LearnFAMType)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">LearnFAMType</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_LearnFAMType)"/>
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
                      <xsl:variable name="var_DateEmpStatApp" select="@DateEmpStatApp"/>
                      <xsl:variable name="var_EmpId" select="@EmpId"/>
                      <xsl:variable name="var_EmpIdLookup" select="@EmpIdLookup"/>
                      <xsl:variable name="var_EmpStat" select="@EmpStat"/>
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
                            <xsl:variable name="var_ESMCode" select="@ESMCode"/>
                            <xsl:variable name="var_ESMType" select="@ESMType"/>
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
                  <!--<entity>
				<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
				<xsl:attribute name="id">LearnerContact</xsl:attribute>
				<xsl:attribute name="complete"><xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/></xsl:attribute>
				<xsl:for-each select="LearnerContact">
					<xsl:variable name="var_ContType" select="@ContType"/>
					<xsl:variable name="var_LocType" select="@LocType"/>
					<xsl:variable name="var_Postcode" select="@Postcode"/>
					<xsl:variable name="var_PostcodeLookup" select="@PostcodeLookup"/>
					<instance>
						<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
						<xsl:if test="string(boolean($var_ContType)) != 'false'">
							<attribute>
								<xsl:attribute name="id">ContType</xsl:attribute>
								<number-val>
									<xsl:value-of select="string($var_ContType)"/>
								</number-val>
							</attribute>
						</xsl:if>
						<xsl:if test="string(boolean($var_LocType)) != 'false'">
							<attribute>
								<xsl:attribute name="id">LocType</xsl:attribute>
								<number-val>
									<xsl:value-of select="string($var_LocType)"/>
								</number-val>
							</attribute>
						</xsl:if>
						<xsl:if test="string(boolean($var_Postcode)) != 'false'">
							<attribute>
								<xsl:attribute name="id">Postcode</xsl:attribute>
								<text-val>
									<xsl:value-of select="string($var_Postcode)"/>
								</text-val>
							</attribute>
						</xsl:if>
						<xsl:if test="string(boolean($var_PostcodeLookup)) != 'false'">
							<attribute>
								<xsl:attribute name="id">PostcodeLookup</xsl:attribute>
								<boolean-val>
									<xsl:value-of select="string($var_PostcodeLookup)"/>
								</boolean-val>
							</attribute>
						</xsl:if>
			</entity>-->

                  <!--<entity>
				<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
				<xsl:attribute name="id">PostAdd</xsl:attribute>
				<xsl:attribute name="complete"><xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/></xsl:attribute>
				<xsl:for-each select="PostAdd">
					<xsl:variable name="var_AddLine1" select="@AddLine1"/>
					<instance>
						<xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
						<xsl:if test="string(boolean($var_AddLine1)) != 'false'">
							<attribute>
								<xsl:attribute name="id">AddLine1</xsl:attribute>
								<text-val>
									<xsl:value-of select="string($var_AddLine1)"/>
								</text-val>
							</attribute>
						</xsl:if>


					</instance>
				</xsl:for-each>
			</entity>
					</instance>
				</xsl:for-each>
			</entity>-->
                  <entity>
                    <xsl:attribute name="id">
                      <xsl:value-of select="generate-id(.)"/>
                    </xsl:attribute>
                    <xsl:attribute name="id">ContactPreference</xsl:attribute>
                    <xsl:attribute name="complete">
                      <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                    </xsl:attribute>
                    <xsl:for-each select="ContactPreference">
                      <xsl:variable name="var_ContPrefCode" select="@ContPrefCode"/>
                      <xsl:variable name="var_ContPrefType" select="@ContPrefType"/>
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
                    <xsl:attribute name="id">LLDDandHealthProblem</xsl:attribute>
                    <xsl:attribute name="complete">
                      <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                    </xsl:attribute>
                    <xsl:for-each select="LLDDandHealthProblem">
                      <xsl:variable name="var_LLDDCat" select="@LLDDCat"/>
                      <xsl:variable name="var_PrimaryLLDD" select="@PrimaryLLDD"/>
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
                  <entity>
                    <xsl:attribute name="id">
                      <xsl:value-of select="generate-id(.)"/>
                    </xsl:attribute>
                    <xsl:attribute name="id">LearnerHE</xsl:attribute>
                    <xsl:attribute name="complete">
                      <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                    </xsl:attribute>
                    <xsl:for-each select="LearnerHE">
                      <xsl:variable name="var_TTACCOM" select="@TTACCOM"/>
                      <xsl:variable name="var_UCASPERID" select="@UCASPERID"/>
                      <instance>
                        <xsl:attribute name="id">
                          <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_TTACCOM)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">TTACCOM</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_TTACCOM)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_UCASPERID)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">UCASPERID</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_UCASPERID)"/>
                            </number-val>
                          </attribute>
                        </xsl:if>


                        <entity>
                          <xsl:attribute name="id">
                            <xsl:value-of select="generate-id(.)"/>
                          </xsl:attribute>
                          <xsl:attribute name="id">LearnerHEFinancialSupport</xsl:attribute>
                          <xsl:attribute name="complete">
                            <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                          </xsl:attribute>
                          <xsl:for-each select="LearnerHEFinancialSupport">
                            <xsl:variable name="var_FINTYPE" select="@FINTYPE"/>
                            <instance>
                              <xsl:attribute name="id">
                                <xsl:value-of select="generate-id(.)"/>
                              </xsl:attribute>
                              <xsl:if test="string(boolean($var_FINTYPE)) != 'false'">
                                <attribute>
                                  <xsl:attribute name="id">FINTYPE</xsl:attribute>
                                  <number-val>
                                    <xsl:value-of select="string($var_FINTYPE)"/>
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
                    <xsl:attribute name="id">ProviderSpecLearnerMonitoring</xsl:attribute>
                    <xsl:attribute name="complete">
                      <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                    </xsl:attribute>
                    <xsl:for-each select="ProviderSpecLearnerMonitoring">
                      <xsl:variable name="var_ProvSpecLearnMonOccur" select="@ProvSpecLearnMonOccur"/>
                      <instance>
                        <xsl:attribute name="id">
                          <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_ProvSpecLearnMonOccur)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">ProvSpecLearnMonOccur</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_ProvSpecLearnMonOccur)"/>
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
                    <xsl:attribute name="id">LearnerDestinationAndProgression</xsl:attribute>
                    <xsl:attribute name="complete">
                      <xsl:value-of select="string(((normalize-space('true') = 'true') or (normalize-space('true') = '1')))"/>
                    </xsl:attribute>
                    <xsl:for-each select="LearnerDestinationAndProgression">
                      <xsl:variable name="var_DP_LearnRefNumber" select="@DP_LearnRefNumber"/>
                      <xsl:variable name="var_DP_ULN" select="@DP_ULN"/>
                      <instance>
                        <xsl:attribute name="id">
                          <xsl:value-of select="generate-id(.)"/>
                        </xsl:attribute>
                        <xsl:if test="string(boolean($var_DP_LearnRefNumber)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">DP_LearnRefNumber</xsl:attribute>
                            <text-val>
                              <xsl:value-of select="string($var_DP_LearnRefNumber)"/>
                            </text-val>
                          </attribute>
                        </xsl:if>
                        <xsl:if test="string(boolean($var_DP_ULN)) != 'false'">
                          <attribute>
                            <xsl:attribute name="id">DP_ULN</xsl:attribute>
                            <number-val>
                              <xsl:value-of select="string($var_DP_ULN)"/>
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
                            <xsl:variable name="var_OutCode" select="@OutCode"/>
                            <xsl:variable name="var_OutStartDate" select="@OutStartDate"/>
                            <xsl:variable name="var_OutType" select="@OutType"/>
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
          </instance>
        </xsl:for-each>
      </entity>

    </session-data>
  </xsl:template>
</xsl:stylesheet>
