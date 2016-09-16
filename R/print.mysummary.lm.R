#���mysummary.lm��Ĵ�ӡ����:
print.mysummary.lm <-
  function(x, digits = max(3L, getOption("digits") - 3L),
           #����signif.stars,������֮��ͻ��������printCoefmat����
           #�����õ���������ʱ��ʾ�Ǻ�.
           signif.stars = getOption("show.signif.stars"), ...) {
    cat("\nCall:\n", paste(deparse(x$call), sep = "\n", collapse = "\n"),
        "\n\n", sep = "")
    resis2 <- x$resis[-4]
    cat("Residuals:\n")
    nam <- c("Min", "1Q", "Median", "3Q", "Max")
    names(resis2) <- nam
    print(resis2)
    cat("\nCoefficients:\n")
    #ע��Coefficients�е�C�Ǵ�д��С�ĳ�����
    coefs <- x$Coefficients
    rcn <- rownames(coefs)
    ccn <- colnames(coefs)
    coefs <- matrix(coefs, ncol = 4, dimnames = list(rcn, ccn))
    #�������ʱ������printCoefmat����.
    printCoefmat(
      #signif.stars���������Ǻ�.
      coefs, digits = digits, signif.stars = signif.stars,
      na.print = "NA", ...
    )
    cat("\n")
    print(x$an)
    cat(
      "\nResidual standard error:", format(x$sigma),
      "on", format(x$rdf), "degrees of freedom"
    )
    cat("\nMultiple R-squared: ", format(x$r.squared,
                                         digits = digits))
    cat(",\tAdjusted R-squared: ", format(x$adj.r.squared,
                                          digits = digits))
    cat(
      "\nF-statistic: ", format(x$fstatistic[1L],
                                digits = digits), "on", x$fstatistic[2L], "and",
      x$fstatistic[3L], "DF,  p-value: ",
      format.pval(
        pf(x$fstatistic[1L], x$fstatistic[2L],
           x$fstatistic[3L], lower.tail = FALSE),
        digits = digits
      )
    )
    cat("\n\n")
    invisible(x)
  }