#Ϊ���ͺ���mysummary����һ��lm��:
mysummary.lm <- function(regmodel, ...) {
  z <- regmodel
  ans <- z[c("call")]
  #��summary��������в����С,���ֵ,1/4,3/4��λ��
  ans$resis <- summary(z$residuals)
  coef <- z$coefficients
  #vcov��������ع�ϵ����Э�������,diagȡ��
  #�Խ���Ԫ��(������),���sqrt�����׼��.
  sd <- sqrt(diag(vcov(z)))
  #tֵ���ڻع�ϵ������ֵ���Ա�׼��
  tv <- coef(z) / sd
  #�ع������tֵ�������ɶ�Ϊn-2��t�ֲ�
  tm <- qt(0.975, df = df.residual(z))
  #tͳ������pֵ,��tֵΪ����ʱ,����lower.tail=F(��p(X<x)),
  #tֵΪ����ʱ,lower.tail=T(��p(X>x)),Ϊ�˱����鷳,ʹ��
  #����ֵ��,��Ϊ����,lower.tail=F.
  #����PֵʱҪ����2!
  tp <- 2 * pt(abs(tv), df = df.residual(z),lower.tail = FALSE)
  ans$Coefficients <- cbind(z$coef,tv,tm,tp)
  colnames(ans$Coefficients) <- c("Estimate","t Values",
                                  "Margin","Pr(>|t|)")
  #ֱ�ӵ���anova����,����洢��an��.��print.summary.lm������
  #ֱ�Ӵ�ӡ��an�����ɵõ�����������.
  an <- anova(z)
  ans$an <- an
  ans$sigma <- summary(z)$sigma
  ans$rdf <- summary(z)$df[2L]
  ans$r.squared <- summary(z)$r.squared
  ans$adj.r.squared <- summary(z)$adj.r.squared
  ans$fstatistic <- summary(z)$fstatistic
  #����mysummary.lm��
  structure(ans,class = "mysummary.lm")
}