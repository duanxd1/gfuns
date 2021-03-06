#' Function to calculate Parial replacement of flow through volume following Sprague
#'
#' Provide 3 of 4 parameters and return the fourth
#'
#' for use in toxicity testing from http://www.nethawaii.net/~kraul/publications/waterchange.html
#' Practical Formulas for Computing Water Exchange Rates
#' Scanned from a reprint of Progressive Fish-Culturist, 47(1), 1985, pp. 69-70.
#' Reported data on water exchanges rates in aquaria and aquaculture systems are often confusing because different methods of exchange result in different amounts of water replacement. For example, in a batch or discrete replacement, if half the volume of water is removed and then replaced with new water,the tank will have 50% new water. However,in a continuous flow system, if 50% new water is added gradually to a full tank and completely mixed water is allowed to spill out, some new water will go out with the old water,and the tank will retain only 39% new water. This difference is usually not critical, and publications may avoid the issue by stating "50% of tank volume was added per day," instead of the more ambiguous "50% of the water was exchanged."
#' For some applications, it is important to know exactly how much water has been exchanged. Examples include dilution of antibiotics and other medications, and optimum dilution of excreted wastes.
#' Sprague (1969) plotted the times for replacing 50, 75, 90, 95, and 99% of existing water against flow rates in continuous systems. A more comprehensive formula for determining dilution in the Great Lakes is presented by Rainey (1967). Most aquarium and aquaculture systems are not as complex as Lake Erie, and a general formula can be derived from Rainey?s equations for simple cases of continuous flow dilution. Three arrangements of this formula are:
#' 1) F= 1-(1/e^(TR/v)) =1-(e^(-TR/v))
#' 2) T= -ln(1-F)V/R
#' 3) R= -ln(1-F)V/T
#' where V=volume of the system, R=rate of water input (ie, liters/hour), T = time water is flowing, and F= the fraction of new water actually replaced in the system. These formulas assume complete mixing of input water before outflow, and were verified by measuring change in salinity when mixing fresh and salt water.
#' Note: page 70 figures not translated on scanner)
#' Fig. 1. Percent water replaced versus percent added in a thoroughly mixed continuous flow system. The dashed line indicates the exchange achieved by discrete water replacement.
#' Fig. 2. Flow rate (R) required for fractional (F) water replacement during any time period (T) for a tank of known volume (V). The upper horizontal axis is specifically for a tank of 4000 liters volume.
#' Formula #1 can be used to compute the fraction of water replaced in a given time when the flow rate and container volume are known. TR/V is equal to the fraction of water added to the container. Figure 1 is based on formula #1 for converting the fraction of water added to the actual fraction retained. Note that the actual percent replaced is almost equal to the percent added below 25%, but differs significantly when 100% or more new water is added. For example, if 20% of the water volume is added continuously every day, the water actually replaced at the end of 5 days is 63%.
#' Formula #2 can be used to compute the time needed to replace old water such as polluted or treated water with any fraction (F) of new water, if the container volume and water inflow rates are known. The equation expresses the relationship illustrated by Sprague (1969), and allows for computation of flow time for any desired fractional replacement.
#' Formula #3 can be used to compute the rate of water flow needed to replace any fraction of water in a specified time. Figure 2 is similar to Sprague?s (1969) graph, and is included as one method of using these formulas. Graphs or tables can be prepared from the formulas for tank volumes and exchange rates that are most useful for each facility.
#' References Cited:
#' Rainey, R. H. 1967. Natural displacement of pollution from the Great Lakes. Science 155:1242.
#' Sprague, J. B. 1969. Measurement of pollutant toxicity to fish. Part I. Water Research 3:793-821.
#' Authors:
#' Syd Kraul, Waikiki Aquarium, 2777 Kalakaua Ave, Honolulu, HI 96815.
#' Jim Szyper, Hawaii Institute of Marine Biology, Coconut Island, Kaneohe, HI 96744
#' Bob Bourke, National Marine Fisheries Service, P.O. Box 3830, Honolulu, HI 96812
#' Post-publishing note:The information presented in the figures is easily derived with a TI-55 CALCULATOR, if you dont have access to the publication. Examples of Percent of volume added, with Actual replacement in parentheses:
#' 400%(98), 300%(95), 200%(86),100%(63), 99%(63),
#' 95%(61), 90%(59), 80%(55), 75%(53), 70%(50)
#' 60%(45), 50%(39), 40%(33), 30%(26), 25%(22),
#' 20%(18), 15%(14), 10%(10), 5%(5)
#' volume=volume of the system Liters
#' rate=rate of water input (ie, liters/hour)
#' flow.time= time water is flowing
#' fraction= the fraction of new water actually replaced in the system
#' stock=concentration of stock or inflow solution
#'
#' @param flowTime Time of flow
#' @param flowRate Rate of flow
#' @param volume Volume of reservoir
#' @param fraction Fraction replacement
#' @export
partialReplacement <- function(
  flowTime = NULL, flowRate = NULL, volume = NULL, fraction = NULL){

 if(is.null(flowTime)){
   flowTime <- -log(1-fraction)*volume/flowRate
 } else if(is.null(flowRate)){
   flowRate <- -log(1-fraction)*volume/flowTime
 } else if(is.null(volume)){
   volume <- 1/(-log(1 - fraction)/flowRate * 1/flowTime)
 }else if(is.null(fraction)){
   fraction <- 1-(exp(-flowTime*flowRate/volume))
 }
  list(
    flowTime = flowTime,
    flowRate = flowRate,
    volume = volume,
    fraction = fraction
  )
}

#' Wrapper to partialReplacement
#'
#' Generates partial replacement based on experimental conditions
#' @param flowTime Time of flow
#' @param flowRate Rate of flow
#' @param volume Volume of reservoir
#' @param fraction Fraction replacement
#' @param timeUnits = "min" use units as defined in package measurements
#' @param volumeUnits = "l" use units as defined in package measurements
#' @param totalTime total duration of exposure
#' @param totalTimeUnits total duration of exposure units
#' @param concentration exposure concentration
#' @param concentrationUnits exposure concentration units
#' @param contaminant name of contaminant
#' @export
exposurePR <-
  function(
    flowTime = NULL, flowRate = NULL, volume = NULL, fraction = NULL,
    flowTimeUnits = "min", flowVolumeUnits = "l",
    totalTime, totalTimeUnits = "hr",
    concentration = NULL, concentrationUnits = "mg_per_l", contaminant = NA){

    # Harmonize units
    if(!is.null(flowTime)){
      flowTime_ <-
        measurements::conv_unit(flowTime, flowTimeUnits, "sec")
    } else flowTime_ <- NULL
    if(!is.null(flowRate)){
      flowRate_ <- measurements::conv_unit(flowRate, paste0(flowVolumeUnits, "_per_", flowTimeUnits), "l_per_sec")
    } else flowRate_ <- NULL
    if(!is.null(volume)){
      volume_ <-
        measurements::conv_unit(volume, volumeUnits, "l")
    } else volume_ <- NULL
    if(!is.null(totalTime)){
      totalTime_ <-
        measurements::conv_unit(totalTime, totalTimeUnits, "sec")
    } else totalTime_ <- NULL


    # Call partialReplacement
    pr <- partialReplacement(flowTime_, flowRate_, volume_, fraction)

    # Prepare concentration curve
    # Plot limits
    # used to bound the flowtime_seq and annotate
    plotLimits <-
      data.frame(fraction = c(0.50, 0.95, 0.99))
    # Time to replacement
    plotLimits$flowTime <-
      apply(plotLimits, 1,
            function(x){
              partialReplacement(
                flowRate = pr$flowRate,
                volume = pr$volume, fraction = x)$flowTime
            })
    plotLimits$concentration <- plotLimits$fraction * concentration

    # if totaltime does not include 99%, use 99% replacement
    if(totalTime_ < plotLimits$flowTime[plotLimits$fraction == 0.99]){
      totalTime_ <- plotLimits$flowTime[plotLimits$fraction == 0.99]
    }

    # Build data frame
    concFrame <-
      data.frame(flowTime = seq(0, totalTime_, 60),
                 flowRate = flowRate_,
                 volume = volume_)

    # Calculate Replacement
    concFrame$fraction <-
      apply(concFrame, 1,
            function(x){
              partialReplacement(
                flowTime = x[["flowTime"]],  flowRate = x[["flowRate"]],
                volume = x[["volume"]])$fraction
            })

    # Calculated Concentration
    concFrame$concentration <- concFrame$fraction * concentration

    # Time units back to original
    concFrame$flowTime <- measurements::conv_unit(concFrame$flowTime, "sec", timeUnits)
    plotLimits$flowTime <- measurements::conv_unit(plotLimits$flowTime, "sec", timeUnits)

    flowRateUnits <- paste0(flowVolumeUnits, "/", flowTimeUnits)

    (concPlot <-
        ggplot2::ggplot(concFrame) +
        ggplot2::geom_line(ggplot2::aes(x = flowTime, y = concentration)) +
        ggplot2::geom_segment(data = plotLimits,
                              ggplot2::aes(x = flowTime, xend = flowTime,
                                           y = 0, yend = concentration),
                              color = c("purple", "blue", "red")) +
        ggplot2::geom_segment(data = plotLimits,
                              ggplot2::aes(x = 0, xend = flowTime,
                                           y = concentration, yend = concentration),
                              color = c("purple", "blue", "red")) +
        ggplot2::xlab(timeUnits) +
        ggplot2::ylab(paste0(contaminant, concentrationUnits)) +
        ggplot2::ggtitle(paste("Concentration gradient given flowRate =",
                               round(flowRate, 2), flowRateUnits,
                               "Volume =", round(volume, 2), volumeUnits)))

    list(
      flowTime = pr$flowTime,
      timeUnits = timeUnits,
      flowRate = pr$flowRate,
      flowRateUnits = flowRateUnits,
      volume = pr$volume,
      volumeUnits = volumeUnits,
      fraction = fraction,
      Plot = concPlot
    )
  }

# exposurePR(
#       flowTime = NULL, flowRate = 1, volume = 45, fraction = 0.95,
#       totalTime = 24, totalTimeUnits = "hr",
#       timeUnits = "min", volumeUnits = "l",
#       concentration = 10, concentrationUnits = "mg_per_l", Contaminant = "KCl")
