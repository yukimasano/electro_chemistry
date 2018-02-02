
# Chronoamperometry, Linear Sweep Voltametry and Sine Wave Voltametry
(For code description see bottom)

This project investigates the electro chemical redox-reactions that take place on a boundary, such as present in a battery. The physical reactions are modelled using Partical Differential Equations and numerical schemes (implemented in Matlab) are used to simulate them and validate analytical results. simulation for electro chemical redox-reactions 

## Intro
An electrochemical system contains two main parts, the electrode, an electronic conductor, and the electrolyte, an ionic conductor containing electroactive chemicals. Our measurements will simulate a three-electrode potentiostat, where we will apply a time-dependent potential between the ‘working’ electrode and the reference electrode and measure the current that flows between the working and the auxiliary electrodes as a response. 
We simplify our system by focussing on the reactions taking place at the working electrode and the electrolyte.  By applying a potential, additional energy can be supplied or taken from the electrons in the electrode. For metallic conductors, this means an increase or decrease in their highest possible energy for the electrons in the electron cloud, called the Fermi-energy. As the electrons in metals do not posses discrete energy levels (due their overlaps in electron orbits) they form a continuous spectrum up to the Fermi- energy. Hence by increasing the potential, the Fermi-level can be lowered below the highest occupied molecular orbit (HOMO) of the reactant particles A, favouring a transfer of electrons as it releases energy. This will lead to a formation of oxidised B particles at the electrode and a peak in our (simulated) measurement. Conversely, the potential can also be lowered such that an reduction process will be favourable and the electrons move from the electrode to the lowest unoccupied molecular orbital (LUMO) of the reactant re-forming A particles.

## Model
We model our system in one dimension:

<img src="https://user-images.githubusercontent.com/29401818/35733742-724e4088-0816-11e8-841b-2074aef03dd1.png" height ="200">

Equations:
Our diffusion equations for particles A and B are given by:

<img src="https://user-images.githubusercontent.com/29401818/35733788-a4d499d0-0816-11e8-8253-de83ab52f3e3.png" height ="150">

With boundary conditions:

<img src="https://user-images.githubusercontent.com/29401818/35733786-a47953f4-0816-11e8-98e3-bf923d468b78.png" height ="50">

<img src="https://user-images.githubusercontent.com/29401818/35733787-a498ddb4-0816-11e8-9ba6-d4ef20cbf53c.png" height ="50">

And we additionally have the conservation of mass:

<img src="https://user-images.githubusercontent.com/29401818/35733785-a461fb5a-0816-11e8-87dc-00ce566924c1.png" height ="50">

## Chronoamperometry
Chronoamperometry is a method for obtaining characteristics about the chemicals. It borrows its name from the application of a potential and analysing the resulting cur- rent as a function of time. Here, the potential is increased by a single step presenting a rapid shift from a region where no faradaic processes can occur to one where all par- ticles at the surface are oxidised immediately. This will quickly lead to a build-up of a boundary layer as A particles are oxidising as fast as they arrive with diffusion and B particles do not further react. Hence, this leads to a decrease in current after the initial peak, converging to the diffusion-limited current with time. Observing the slope of the response and the effect of lowering the step size can yield insights into the chemical properties, namely the diffusion constants and the number of electrons transferred
We only note that after some maths, we can derive [Cottrell's law](https://en.wikipedia.org/wiki/Cottrell_equation).

<img src="https://user-images.githubusercontent.com/29401818/35734063-b29d9d18-0817-11e8-8816-91cddabc26e4.png" height ="250">

## Linear Sweep Voltrametry
Instead of a rapid step increase in the potential, voltammetric methods allow differ- ent functions for the potential to be created and its response monitored. This will result in more complicated curves yielding information not only about diffusion rates and stoichiometry but also about the reversibility of a reaction and the detection of chemicals even in the order of parts-per-billion. For linear sweep voltammetry, the potential Edc(t) follows a ‘hat’ function with a linear increase and a subsequent linear decrease.
After some maths, we get the [Butler-Volmer boundary condition](https://en.wikipedia.org/wiki/Butler%E2%80%93Volmer_equation) with which we can study the kinetics of the reactions:

### Varying k0
We analyze the effects of varying the base reaction rate k0 on the I vs E(t) phasediagram:

<img src="https://user-images.githubusercontent.com/29401818/35734300-93199f5e-0818-11e8-9d88-9dfd4360ef06.png" height ="300">

### Varying alpha
We need to note here, that the reactants do not have a single energy level, but instead follow a Boltzmann distribution because of the non-zero temperature. This can be incorporated by taking kred/ox ∝ exp(−∆G_red/ox ), RT
where ∆G_red/ox is the difference in the (free Gibbs) energy of the reactant and the oxidant to the transition state, respectively. The gas constant R and the temperature T are constant. Not only is the energy of the electrons changed with the applied voltage, but also that of the transition state and so of ∆G+red/ox. We approximate this effect with a linear relationship:

<img src="https://user-images.githubusercontent.com/29401818/35734474-358bcdc0-0819-11e8-8958-a7721969f7ec.png" height ="50">

where alpha is called the transfer coefficient and represents the influence of a change in applied potential E on the energy level of the transition state. The constant ∆G0 is only dependent on the chemicals involved.

<img src="https://user-images.githubusercontent.com/29401818/35734647-d04b05f6-0819-11e8-960c-06069ff5090a.png" height ="300">


We can see from the reverse sweep current response curve of α = 0.999, the peak for the reduction current has a very small amplitude. This is due to the fact that not ‘enough’ B particles have been produced to fully exploit the high rate and hence no high current is produced. By focusing on α = 0.1, we can see the opposite phenomenon: As the electrolyte initially only contains A particles, we have a very high peak oxidation current with around Ipeak ≈ 0.47. From the transition state theory we can interpret the case of α ≈ 0 as an transition state that is independent on the applied voltage (at least to the first order). This explains the high reaction rate as well the lower potential at which the peak occurs.
 
## Sine Wave Voltametry
It's simple: now I(t) is a sine wave with amplitude ∆E and frequency ω plus a constant DC current. 
 
### Varying ∆E
 
<img src="https://user-images.githubusercontent.com/29401818/35734757-1e2798ca-081a-11e8-9b8d-13f92604fbc0.png" height="300">
 
We can observe two effects of increasing the sinusoidal amplitude: First, increasing the amplitude increases the peak current and shifts the peak position to lower values of Edc ≈ 2,4. As this shift is proportional to the amplitude, it is likely caused by the fact that E(t) will approach its Edc peak value earlier when an additional potential is applied. Second, in the case of ∆E = 5, we can see the oscillations of the response current having higher amplitudes in the positive direction. This can be explained by the increased ability to oxidise A particles but a limited ability to reduce B particles due to their relative shortage near the electrode.


### Varying ω
 
<img src="https://user-images.githubusercontent.com/29401818/35734793-3e2c76ae-081a-11e8-81ee-be96c1b790c7.png" height="300">

By introducing the sine wave potential, we increase the local slope of the applied potential and obtain
higher peak currents from the [Randles-Seijvik equation](https://en.wikipedia.org/wiki/Randles%E2%80%93Sevcik_equation): I ∝ sqrt(α ν), where ν is the slope of the potential. In our case:
ν ∝ ω cos(ωt). We can confirm this relationship in our experiment:

 <img src="https://user-images.githubusercontent.com/29401818/35735152-8cda96e0-081b-11e8-8f4d-58f05db382c7.png" height="300">


## Conclusion
Further work can be divided into two topics. First, the numerical side: As the most important phenomena occur close to the electrode, considering a non-uniform mesh (with a higher gridpoint density near the electrode) will give gains in both accuracy and speed. Furthermore, the simulations will resemble reality closer when increasing the dimension of the simulation to two. Second, the chemical side: Considering more complex reaction mechanisms with intermediary products, multiple electron transfers, electroinactive products and different diffusion constants will allow the model to simulate a much wider range of electrochemical reactions. Additionally, considering non-linear inter- actions (e.g. from the mass-action law which states that a reaction is proportional to the product of its reactants concentrations) will allow more accurate models utilising efficient optimization algorithms, such as Newton-Raphson.



# Code
* `sweep.m`: provides the basic sweep function
* `sweep_sin.m`: provides the sin-sweep function
* `vary_*.m`: * = K0,E0,w etc.: Files that do the simulations by calling the above two functions and automatically generate plots.
